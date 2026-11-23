import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

import '../data/sync/drive_files.dart';
import '../data/sync/google_drive_files.dart';

abstract interface class DriveSignIn {
  /// False when no OAuth client id was supplied at build time, or on a
  /// platform that cannot sign in yet.
  bool get isAvailable;

  /// Why Drive is unavailable, for the UI. Null when available.
  String? get unavailableReason;

  /// Signs in without prompting if the user already did.
  Future<DriveFiles?> restore();

  /// Prompts the user. Null if cancelled or failed.
  Future<DriveFiles?> signIn();

  Future<void> signOut();
}

class GoogleDriveSignIn implements DriveSignIn {
  // Supplied with --dart-define; see docs/drive-setup.md.
  static const _clientId = String.fromEnvironment('GOOGLE_CLIENT_ID');
  static const _serverClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
  );
  static const _tokenLifetime = Duration(minutes: 30);

  Future<void>? _initialized;
  DriveFiles? _cached;
  DateTime? _cachedAt;

  @override
  String? get unavailableReason {
    if (kIsWeb) return 'Not available in the browser yet';
    if (_serverClientId.isEmpty) {
      return 'Needs a Google Cloud client id (see docs/drive-setup.md)';
    }
    return null;
  }

  @override
  bool get isAvailable => unavailableReason == null;

  Future<void> _ensureInitialized() =>
      _initialized ??= GoogleSignIn.instance.initialize(
        clientId: _clientId.isEmpty ? null : _clientId,
        serverClientId: _serverClientId.isEmpty ? null : _serverClientId,
      );

  @override
  Future<DriveFiles?> restore() async {
    if (!isAvailable) return null;
    final cachedAt = _cachedAt;
    if (_cached != null &&
        cachedAt != null &&
        DateTime.now().difference(cachedAt) < _tokenLifetime) {
      return _cached;
    }

    await _ensureInitialized();
    final account = await GoogleSignIn.instance
        .attemptLightweightAuthentication();
    return account == null ? null : _filesFor(account, interactive: false);
  }

  @override
  Future<DriveFiles?> signIn() async {
    if (!isAvailable) return null;
    await _ensureInitialized();
    if (!GoogleSignIn.instance.supportsAuthenticate()) return null;
    try {
      final account = await GoogleSignIn.instance.authenticate();
      return await _filesFor(account, interactive: true);
    } on GoogleSignInException {
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    _cached = null;
    _cachedAt = null;
    if (!isAvailable) return;
    await _ensureInitialized();
    await GoogleSignIn.instance.signOut();
  }

  Future<DriveFiles?> _filesFor(
    GoogleSignInAccount account, {
    required bool interactive,
  }) async {
    final client = account.authorizationClient;
    var authorization = await client.authorizationForScopes(
      GoogleDriveFiles.scopes,
    );
    if (authorization == null && interactive) {
      authorization = await client.authorizeScopes(GoogleDriveFiles.scopes);
    }
    if (authorization == null) return null;

    final files = GoogleDriveFiles(
      drive.DriveApi(authorization.authClient(scopes: GoogleDriveFiles.scopes)),
    );
    _cached = files;
    _cachedAt = DateTime.now();
    return files;
  }
}
