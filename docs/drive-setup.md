# Google Drive sync setup

Drive sync is optional and off by default. Because HydraTrack has no server, you create your own Google Cloud OAuth
client; nothing is shared with anyone else.

HydraTrack only requests the `drive.appdata` scope. That gives access to a hidden folder reserved for this app. It cannot
see any other file in your Drive.

## 1. Google Cloud project

1. Go to the [Google Cloud console](https://console.cloud.google.com/) and create a project.
2. Enable the **Google Drive API** (APIs & Services, Library).
3. Configure the **OAuth consent screen**. While the app is in "Testing", add your own Google account under Test users.

## 2. OAuth clients

Create these under APIs & Services, Credentials, Create credentials, OAuth client ID:

| Type | Needed for | Notes |
| --- | --- | --- |
| **Web application** | Android sign-in | Its client ID is the *server client ID* used below |
| **Android** | Android sign-in | Package `dev.ngallegos.hydratrack` plus your signing certificate's SHA-1 |

Debug SHA-1: `keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android`

## 3. Build with the client id

```sh
flutter run \
  --dart-define=GOOGLE_SERVER_CLIENT_ID=<web client id>.apps.googleusercontent.com
```

Without the define, the Drive option shows as unavailable.

## Limitations

- Drive sign-in is Android only for now. The browser build uses the same define names but needs Google's web sign-in
  button flow, which is not implemented.
- Not yet tested against a real Google account.
