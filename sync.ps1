<#
.SYNOPSIS
Safely sync the Alpha-SuperApp repository, verify test suite, detect secrets, and commit with smart conventional messaging.

.DESCRIPTION
Automated synchronization workflow for Alpha-SuperApp:
1. Verifies Git repository and active branch.
2. Pulls remote updates with --rebase and --autostash if remote origin exists and branch exists on remote.
3. Runs verification via scripts/verify.py.
4. Stages changes with git add -A.
5. Scans staged changes for accidental credentials, keys, or sensitive evidence dumps.
6. Auto-generates conventional commit messages.
7. Commits and safely pushes to origin.
#>

[CmdletBinding()]
param (
    [Alias("m")]
    [string]$Message,

    [switch]$PullOnly,

    [switch]$SkipTest,

    [switch]$NoPush,

    [switch]$WhatIf
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Write-Status {
    param([string]$Msg, [System.ConsoleColor]$Color = [System.ConsoleColor]::Cyan)
    Write-Host "[$((Get-Date).ToString('HH:mm:ss'))] $Msg" -ForegroundColor $Color
}

function Write-Success {
    param([string]$Msg)
    Write-Host "[$((Get-Date).ToString('HH:mm:ss'))] SUCCESS: $Msg" -ForegroundColor Green
}

function Write-Fail {
    param([string]$Msg)
    Write-Host "[$((Get-Date).ToString('HH:mm:ss'))] ERROR: $Msg" -ForegroundColor Red
}

$repoRoot = $PSScriptRoot
Set-Location $repoRoot

if (-not (Test-Path "$repoRoot\.git")) {
    Write-Fail "Not a git repository: $repoRoot"
    exit 1
}

$currentBranch = (git branch --show-current 2>$null)
if (-not $currentBranch) { $currentBranch = "main" }
$hasRemote = [bool](git remote get-url origin 2>$null)
$remoteBranchExists = if ($hasRemote) { [bool](git ls-remote --heads origin $currentBranch 2>$null) } else { $false }

# 0. Verification Gate
if ((-not $SkipTest) -and (Test-Path "scripts/verify.py")) {
    Write-Status "Running scripts/verify.py..."
    python scripts/verify.py
    if ($LASTEXITCODE -ne 0) {
        Write-Fail "scripts/verify.py reported errors. Fix before committing."
        exit $LASTEXITCODE
    }
}

# 1. Pull
if ($hasRemote -and $remoteBranchExists) {
    Write-Status "Pulling latest updates from origin/$currentBranch..."
    git pull --rebase --autostash origin $currentBranch
    if ($LASTEXITCODE -ne 0) {
        Write-Fail "git pull encountered conflicts or errors."
        exit $LASTEXITCODE
    }
} else {
    Write-Status "Branch $currentBranch is local-only or no remote. Skipping initial pull."
}

if ($PullOnly) {
    Write-Success "Pull completed successfully (-PullOnly active)."
    exit 0
}

# 2. Stage
Write-Status "Staging changes..."
git add -A

$stagedDiff = git diff --cached --name-only
if (-not $stagedDiff) {
    Write-Success "Working directory clean. No changes to commit."
    exit 0
}

# 3. Secret Scanning
$secretPatterns = @(
    'AKIA[0-9A-Z]{16}',
    'ghp_[0-9a-zA-Z]{36}',
    'github_pat_[0-9a-zA-Z_]{82}',
    'AIza[0-9A-Za-z\-_]{35}',
    '-----BEGIN [A-Z ]*PRIVATE KEY-----'
)

$diffContent = git diff --cached
foreach ($pattern in $secretPatterns) {
    if ($diffContent -match $pattern) {
        Write-Fail "High-entropy secret or credential matched pattern: $pattern. Aborting commit!"
        exit 1
    }
}

# 4. Commit Message
if (-not $Message) {
    $Message = "chore: update Alpha-SuperApp build and modules"
}

if ($WhatIf) {
    Write-Status "[Dry-Run] Would commit with message: '$Message'"
    Write-Status "[Dry-Run] Staged files:`n$stagedDiff"
    git reset
    exit 0
}

# 5. Commit & Push
Write-Status "Committing changes..."
git commit -m $Message
if ($LASTEXITCODE -ne 0) {
    Write-Fail "git commit failed."
    exit $LASTEXITCODE
}

if ($NoPush) {
    Write-Success "Commit created locally (-NoPush active)."
    exit 0
}

if ($hasRemote) {
    Write-Status "Pushing to origin/$currentBranch..."
    git push origin $currentBranch
    if ($LASTEXITCODE -ne 0) {
        Write-Fail "git push failed."
        exit $LASTEXITCODE
    }
}

Write-Success "Ecosystem synchronization completed cleanly."
