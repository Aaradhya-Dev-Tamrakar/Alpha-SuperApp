package com.alpha.core.auth

import android.content.Context
import com.alpha.features.settings.AppSettings
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInAccount
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.common.api.Scope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.tasks.await

class GoogleAuthManager(private val context: Context) {

    private val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
        .requestEmail()
        .requestScopes(Scope("https://www.googleapis.com/auth/drive.appdata"))
        .requestScopes(Scope("https://www.googleapis.com/auth/gmail.readonly"))
        .build()

    private val signInClient: GoogleSignInClient = GoogleSignIn.getClient(context, gso)

    private val _authState = MutableStateFlow<GoogleSignInAccount?>(GoogleSignIn.getLastSignedInAccount(context))
    val authState: StateFlow<GoogleSignInAccount?> = _authState.asStateFlow()

    fun getSignInClient() = signInClient

    fun updateAccount(account: GoogleSignInAccount?) {
        _authState.value = account
    }

    suspend fun signOut() {
        signInClient.signOut().await()
        _authState.value = null
    }

    fun getAccessToken(): String? {
        // In a real app, you'd exchange the server auth code or ID token for an access token
        // using a backend or a direct token request. For this demonstration, we assume
        // the ID token or a previously obtained token is handled.
        // GoogleSignInAccount doesn't directly expose the short-lived access token.
        return _authState.value?.idToken
    }
}
