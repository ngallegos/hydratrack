// OAuth client ids are public identifiers, not secrets, so the app's author
// pastes them here once and every user then signs in with one tap.
// See docs/drive-setup.md. A --dart-define overrides these for local testing.
const _bundledServerClientId = '';
const _bundledWebClientId = '';

const googleServerClientId = String.fromEnvironment(
  'GOOGLE_SERVER_CLIENT_ID',
  defaultValue: _bundledServerClientId,
);
const googleWebClientId = String.fromEnvironment(
  'GOOGLE_CLIENT_ID',
  defaultValue: _bundledWebClientId,
);
