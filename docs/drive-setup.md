# Google Drive sync: one-time setup for the app's author

End users do nothing here. They tap **Sign in with Google** on the Sync screen, approve Google's consent screen, and
they're done. This guide is the one-time job of registering the app with Google so that button works.

HydraTrack only requests the `drive.appdata` scope: a hidden folder reserved for this app. It cannot see any other file in
the user's Drive. This is a non-sensitive scope, so Google does not require an app-verification review.

## 1. Google Cloud project (once)

1. Create a project in the [Google Cloud console](https://console.cloud.google.com/).
2. Enable the **Google Drive API**.
3. **OAuth consent screen**: fill in the app name and support email, add the `drive.appdata` scope, then set the publishing
   status to **In production**. (In "Testing" only listed test users can sign in and tokens expire after 7 days.)

## 2. OAuth clients (once)

Under Credentials, Create credentials, OAuth client ID:

| Type | Notes |
| --- | --- |
| **Web application** | Its client ID is the *server client ID* the Android app needs |
| **Android** | Package `dev.ngallegos.hydratrack` plus the SHA-1 of the certificate that signs the build |

SHA-1 values to register (add one client per certificate):
- Debug: `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android`
- Release: your upload/release key, and if you publish on Google Play, the **Play App Signing** SHA-1 shown in the Play Console

## 3. Put the ids in the app

Paste the web client ID into `_bundledServerClientId` in `lib/platform/google_config.dart` and commit it. Client IDs are
public identifiers, not secrets. Every build, and so every user, then gets one-tap sign-in.

For quick local testing without editing the file:
`flutter run --dart-define=GOOGLE_SERVER_CLIENT_ID=<id>.apps.googleusercontent.com`

Until an ID is set, the Drive option shows "not set up in this build" and everything else works normally.

## Limitations

- Android only for now; web sign-in needs Google's browser button flow, which isn't implemented.
- Not yet tested against a real Google account.
