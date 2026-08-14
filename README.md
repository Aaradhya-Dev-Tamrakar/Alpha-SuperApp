<h1 align="center">Alpha SuperApp</h1>

<p align="center">
  <strong>A modular Android super-app combining AI, computer vision, Bluetooth control, and personal finance — built entirely with Jetpack Compose.</strong>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Android-3DDC84?logo=android&logoColor=white" alt="Platform: Android"/>
  <img src="https://img.shields.io/badge/Language-Kotlin_2.2-7F52FF?logo=kotlin&logoColor=white" alt="Language: Kotlin 2.2"/>
  <img src="https://img.shields.io/badge/UI-Jetpack_Compose-4285F4?logo=jetpackcompose&logoColor=white" alt="UI: Jetpack Compose"/>
  <img src="https://img.shields.io/badge/Min_SDK-26_(Android_8.0)-brightgreen" alt="Min SDK: 26"/>
  <img src="https://img.shields.io/badge/Target_SDK-36-blue" alt="Target SDK: 36"/>
  <img src="https://img.shields.io/badge/License-MIT-yellow" alt="License: MIT"/>
  <img src="https://img.shields.io/badge/Version-1.0.0-orange" alt="Version: 1.0.0"/>
</p>

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Architecture](#architecture)
- [Tech Stack](#tech-stack)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Configuration](#configuration)
- [Dependencies](#dependencies)
- [Build Variants](#build-variants)
- [Permissions](#permissions)
- [Roadmap](#roadmap)
- [Contributing](#contributing)
- [Security](#security)
- [License](#license)
- [Acknowledgments](#acknowledgments)

---

## Overview

**Alpha SuperApp** is a feature-rich, modular Android application that brings together multiple intelligent tools under a single app. From AI-powered web search and real-time hand gesture recognition to personal finance management and a calculator — Alpha SuperApp demonstrates modern Android development at its best.

Built with **Kotlin**, **Jetpack Compose**, and **Material 3**, the app follows **MVVM + Repository** architecture with reactive state management via `StateFlow`. It integrates with Google Gemini AI, MediaPipe for computer vision, CameraX for real-time processing, and Google Drive for cloud sync.

---

## Features

### 🤖 AI-Powered Web Search
- Natural language queries powered by **Google Gemini API**
- **Multimodal search** — attach images alongside text queries
- Real-time streaming results with loading states
- Full error handling and timeout management

### 💰 Budget & Expense Tracker
- Complete personal finance management with transaction tracking
- **Auto-import** transactions from:
  - 📧 Gmail email parsing (bank statements, receipts)
  - 📊 Esewa payment service Excel (.xls) exports
  - 📸 Bill/receipt photo capture via CameraX
- **Google Drive sync** for cross-device data consistency
- Smart duplicate detection and conflict resolution during imports
- Category-based expense classification

### 🖐️ SBR Gesture Control (Hand Gesture → Bluetooth)
- **Real-time hand gesture recognition** using MediaPipe's 21-point hand landmark model
- Camera frame analysis at **~30 FPS** for responsive detection
- **Temporal stability filtering** to eliminate false positives and handle hand tremors
- Debounced command execution for reliability
- **Bluetooth serial communication** to connected devices
- Live camera preview with gesture overlay and color-coded connection status

### 🧮 Calculator
- Clean, touch-friendly arithmetic calculator with percentage and modulo (`MOD`) operators
- Real-time calculation display with intuitive button layout

### ⚙️ Settings & Theming
- **Light / Dark / System-aware** theme modes
- Manual override to set explicit theme preference
- Persistent preferences via Android DataStore
- Material 3 dynamic theming

---

## Screenshots

> *Coming soon — screenshots of the home screen, budget tracker, gesture control, and AI search will be added here.*

---

## Architecture

Alpha SuperApp follows a **clean, feature-first MVVM architecture** with a unidirectional data flow:

```
┌─────────────────────────────────────────────────┐
│                   UI Layer                       │
│         Composable Screens + NavHost              │
│  (collectAsState → reactive re-composition)       │
└─────────────────┬───────────────────────────────┘
                   │ Events ↓        ↑ StateFlow<UiState>
┌─────────────────▼───────────────────────────────┐
│               ViewModel Layer                     │
│   Business logic + State management                │
│   (exposes StateFlow<ScreenState>)                 │
└─────────────────┬───────────────────────────────┘
                   │                ↑
┌─────────────────▼───────────────────────────────┐
│           Repository / Service Layer               │
│   DataStore • Network APIs                          │
│   Google Drive • Gmail • Gemini • Bluetooth          │
└─────────────────────────────────────────────────┘
```

### Key Design Decisions

| Decision | Approach |
|----------|----------|
| **UI framework** | 100% Jetpack Compose — no Fragments |
| **State management** | `StateFlow<ScreenState>` consumed via `collectAsState()` |
| **Navigation** | Jetpack Compose `NavHost` with string routes |
| **Dependency injection** | Manual constructor injection (no Hilt/Dagger) |
| **Data persistence** | Android DataStore for preferences |
| **Error handling** | Errors surfaced via state objects — never thrown to the UI layer |
| **Packaging** | Feature-first: `features/{module}/{Screen\|ViewModel\|Repository}.kt` |

---

## Tech Stack

| Category | Technology | Version |
|----------|-----------|---------|
| **Language** | Kotlin | 2.2.10 |
| **UI** | Jetpack Compose (Material 3) | BOM 2024.02.00 |
| **Build system** | Gradle (Kotlin DSL) | AGP 9.3.1 |
| **AI / ML** | Google Gemini API | via OkHttp |
| **Computer vision** | MediaPipe Tasks Vision | 0.10.14 |
| **Camera** | CameraX | 1.3.4 |
| **Networking** | OkHttp | 4.12.0 |
| **Serialization** | Gson | 2.11.0 |
| **Async** | Kotlin Coroutines | 1.8.1 |
| **Persistence** | DataStore Preferences | 1.1.1 |
| **Auth** | Google Play Services Auth | 21.2.0 |
| **File parsing** | Apache POI | 5.2.5 |
| **Navigation** | Navigation Compose | 2.7.7 |
| **Lifecycle** | Lifecycle Runtime + ViewModel Compose | 2.8.4 |

---

## Project Structure

```
Alpha-SuperApp/
├── app/
│   ├── build.gradle.kts              # App module build config
│   ├── proguard-rules.pro            # R8/ProGuard obfuscation rules
│   └── src/main/
│       ├── AndroidManifest.xml       # Permissions, activities, providers
│       ├── assets/models/
│       │   └── hand_landmarker.task  # MediaPipe hand landmark model
│       ├── java/com/alpha/
│       │   ├── MainActivity.kt       # Single-activity entry point
│       │   │
│       │   ├── core/                 # Shared services
│       │   │   ├── ai/
│       │   │   │   └── GeminiClient.kt         # Gemini API client (text + multimodal)
│       │   │   └── auth/
│       │   │       └── GoogleAuthManager.kt    # Centralized Google Sign-In (Drive + Gmail scopes)
│       │   │
│       │   ├── features/             # Feature modules
│       │   │   ├── budget/           # 💰 Budget tracker
│       │   │   │   ├── BudgetViewModel.kt
│       │   │   │   ├── BudgetRepository.kt
│       │   │   │   ├── BudgetScreen.kt
│       │   │   │   ├── BillPhotoManager.kt     # Receipt camera capture
│       │   │   │   ├── DriveSync.kt            # Google Drive sync
│       │   │   │   ├── GmailParser.kt          # Email transaction extraction
│       │   │   │   ├── EsewaXlsParser.kt       # Esewa XLS import
│       │   │   │   └── models/
│       │   │   │       ├── Transaction.kt
│       │   │   │       └── BudgetState.kt
│       │   │   │
│       │   │   ├── calculator/       # 🧮 Calculator
│       │   │   │   └── CalculatorScreen.kt
│       │   │   │
│       │   │   ├── sbrcontrol/       # 🖐️ Gesture → Bluetooth control
│       │   │   │   ├── SbrControlViewModel.kt
│       │   │   │   ├── SbrControlScreen.kt
│       │   │   │   ├── HandGestureProcessor.kt  # MediaPipe orchestrator
│       │   │   │   ├── GestureLogic.kt          # Landmark → gesture mapping
│       │   │   │   ├── GestureStability.kt      # Temporal smoothing/debounce
│       │   │   │   └── BluetoothComm.kt         # BT serial communication
│       │   │   │
│       │   │   ├── settings/         # ⚙️ Theme & preferences
│       │   │   │   ├── SettingsViewModel.kt
│       │   │   │   ├── SettingsScreen.kt
│       │   │   │   └── AppSettings.kt           # DataStore wrapper
│       │   │   │
│       │   │   └── websearch/        # 🤖 AI web search
│       │   │       ├── WebSearchViewModel.kt
│       │   │       └── WebSearchScreen.kt
│       │   │
│       │   └── ui/                   # Shared UI layer
│       │       ├── home/
│       │       │   └── HomeScreen.kt            # Feature tile grid hub
│       │       ├── navigation/
│       │       │   └── NavGraph.kt              # Central route definitions
│       │       └── theme/
│       │           ├── Color.kt
│       │           ├── Theme.kt                 # Material 3 light/dark
│       │           └── Type.kt                  # Typography scale
│       └── res/
│           ├── drawable/             # Vector drawables & icons
│           ├── font/                 # Custom typefaces
│           ├── mipmap-*/             # Launcher icons
│           ├── values/               # Strings, colors, styles
│           └── xml/                  # FileProvider paths
│
├── gradle/
│   ├── libs.versions.toml            # Centralized version catalog
│   └── wrapper/                      # Gradle wrapper
├── build.gradle.kts                  # Root build config
├── settings.gradle.kts               # Project settings
├── gradle.properties                 # JVM args & AndroidX flag
├── CHANGELOG.md                      # Version history
├── SECURITY.md                       # Security policy
├── LICENSE                           # MIT License
└── local.properties                  # API keys (git-ignored)
```

---

## Getting Started

### Prerequisites

| Requirement | Minimum |
|-------------|---------|
| **Android Studio** | Ladybug (2024.x) or newer |
| **JDK** | 11+ |
| **Android SDK** | API 36 (compile), API 26+ (device/emulator) |
| **Gradle** | 9.x (bundled via wrapper) |

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Aaradhya-Dev-Tamrakar/Alpha-SuperApp.git
   cd Alpha-SuperApp
   ```

2. **Open in Android Studio**
   - File → Open → select the `Alpha-SuperApp` root directory
   - Wait for Gradle sync to complete

3. **Configure API keys** (see [Configuration](#configuration))

4. **Build & Run**
   ```bash
   # Build debug APK
   ./gradlew assembleDebug

   # Install on connected device/emulator
   ./gradlew installDebug
   ```
   Or press ▶️ **Run** in Android Studio.

---

## Configuration

### API Keys

The app reads secrets from `local.properties` (git-ignored). Create or edit this file at the project root:

```properties
# local.properties

# Required for AI Web Search
GEMINI_API_KEY=your_gemini_api_key_here
```

> **How to get a Gemini API key:**
> 1. Visit [Google AI Studio](https://aistudio.google.com/)
> 2. Sign in and create an API key
> 3. Paste it in `local.properties`

### Google Drive & Gmail Integration

Budget sync and email parsing use `GoogleAuthManager` (`core/auth/`), which authenticates via the standard **Google Sign-In** API (Play Services Auth) requesting the `drive.appdata` and `gmail.readonly` scopes. This does not require a `google-services.json` / Firebase setup — it is a plain Play Services Auth integration.

---

## Dependencies

All dependencies are centrally managed in [`gradle/libs.versions.toml`](gradle/libs.versions.toml).

### Core
| Library | Purpose |
|---------|---------|
| `androidx.core:core-ktx` | Kotlin extensions for Android framework |
| `androidx.activity:activity-compose` | Compose integration for Activities |
| `androidx.lifecycle:lifecycle-*` | ViewModel, Lifecycle, runtime Compose |
| `androidx.navigation:navigation-compose` | Compose navigation with `NavHost` |
| `androidx.datastore:datastore-preferences` | Key-value preference persistence |

### UI
| Library | Purpose |
|---------|---------|
| `androidx.compose:compose-bom` | Compose Bill of Materials |
| `androidx.compose.material3:material3` | Material 3 components |
| `androidx.compose.material:material-icons-extended` | Full Material icon set |

### AI & Computer Vision
| Library | Purpose |
|---------|---------|
| `com.google.mediapipe:tasks-vision` | Hand landmark detection (21 keypoints) |
| `androidx.camera:camera-*` | CameraX (core, camera2, lifecycle, view) |

### Networking & Data
| Library | Purpose |
|---------|---------|
| `com.squareup.okhttp3:okhttp` | HTTP client for Gemini & Google APIs |
| `com.google.code.gson:gson` | JSON serialization/deserialization |
| `org.apache.poi:poi` | Excel (.xls) file parsing for Esewa imports |
| `com.google.android.gms:play-services-auth` | Google Sign-In |

### Async
| Library | Purpose |
|---------|---------|
| `org.jetbrains.kotlinx:kotlinx-coroutines-android` | Coroutines for Android |
| `org.jetbrains.kotlinx:kotlinx-coroutines-play-services` | `Task<T>` → coroutine bridge |

---

## Build Variants

| Variant | Minify | Shrink Resources | ProGuard | Use Case |
|---------|--------|-------------------|----------|----------|
| **debug** | ❌ | ❌ | ❌ | Development & testing |
| **release** | ✅ | ✅ | ✅ (`proguard-rules.pro`) | Production distribution |

### Useful Gradle Commands

```bash
# Build debug APK
./gradlew assembleDebug

# Build release APK
./gradlew assembleRelease

# Run unit tests
./gradlew test

# Clean build
./gradlew clean

# Install debug build on device
./gradlew installDebug
```

---

## Permissions

| Permission | Required By | Purpose |
|------------|-------------|---------|
| `INTERNET` | AI Search, Budget Sync | API calls to Gemini, Google Drive, Gmail |
| `CAMERA` | SBR Control, Budget | Hand gesture recognition, bill photo capture |
| `BLUETOOTH` | SBR Control | Bluetooth device pairing |
| `BLUETOOTH_CONNECT` | SBR Control | Active Bluetooth communication |
| `BLUETOOTH_SCAN` | SBR Control | Bluetooth device discovery |

All permissions follow Android runtime permission best practices. Camera and Bluetooth permissions are requested only when the user navigates to features that require them.

---

## Roadmap

### v1.1.0 (In Progress)

- [ ] 🌐 **HTML Viewer** — Local HTML/CSS/JS file viewer with WebView, file picker, and folder browser
- [ ] 🥗 **Calorie Tracker** — Food logging with Open Food Facts API and Gemini photo recognition; Room database for date-based queries
- [ ] 🏠 **Home Screen Categories** — Grid/List/Sectioned layout modes with sticky headers (Finance, Tools, AI, Device, System)
- [ ] 💰 **Budget: Income Tracking** — `INCOME`/`EXPENSE` transaction types, net worth calculation, recurring income via WorkManager
- [ ] 🐛 **Budget: Crash Fix** — Null-safety guards during DataStore deserialization

### Future

- 📊 Budget analytics & spending forecasts
- 📤 Export transactions for tax preparation
- 👥 Multi-user support with cloud sync
- 🎮 Additional gesture commands for SBR devices
- 🔌 Plugin system for community feature modules

---

## Contributing

Contributions are welcome! Here's how to get started:

1. **Fork** the repository
2. **Create** a feature branch
   ```bash
   git checkout -b feature/amazing-feature
   ```
3. **Commit** your changes with descriptive messages
   ```bash
   git commit -m "feat: add amazing feature"
   ```
4. **Push** to your branch
   ```bash
   git push origin feature/amazing-feature
   ```
5. **Open** a Pull Request

### Guidelines

- Follow Kotlin coding conventions and Android best practices
- Use feature-first packaging (`features/{module}/`)
- Expose state via `StateFlow`, never throw errors to the UI layer
- All UI must be Composable functions — no Fragments
- Write meaningful commit messages (consider [Conventional Commits](https://www.conventionalcommits.org/))

Please review [SECURITY.md](SECURITY.md) before contributing security-sensitive code.

---

## Security

We take security seriously. Please see our [Security Policy](SECURITY.md) for:

- **Responsible disclosure** process for vulnerabilities
- **Sensitive data** handling guidelines
- **API key** management best practices
- **Dependency** vulnerability monitoring

> ⚠️ **Never commit** API keys, signing keystores, or `local.properties` to version control.

**Report vulnerabilities:** [aaradhyadevtmr@gmail.com](mailto:aaradhyadevtmr@gmail.com)

---

## License

This project is licensed under the **MIT License** — see the [LICENSE](LICENSE) file for details.

```
MIT License • Copyright (c) 2026 Alpha SuperApp Contributors
```

---

## Acknowledgments

- **Developer:** [Aaradhya Dev Tamrakar](mailto:aaradhyadevtmr@gmail.com)
- **Google** — Gemini AI, MediaPipe, CameraX, Jetpack Compose, Material 3
- **Square** — OkHttp
- **Apache** — POI for Excel parsing
- **JetBrains** — Kotlin, Coroutines

---

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the full version history.

---

<p align="center">
  <sub>Built with ❤️ using Kotlin & Jetpack Compose</sub>
</p>