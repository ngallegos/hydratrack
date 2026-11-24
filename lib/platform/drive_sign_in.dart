import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/drive/v3.dart' as drive;
import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';

import '../data/sync/drive_files.dart';
import '../data/sync/google_drive_files.dart';
import 'google_config.dart';

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
  static const _tokenLifetime = Duration(minutes: 30);

  Future<void>? _initialized;
  DriveFiles? _cached;
  DateTime? _cachedAt;

  @override
  String? get unavailableReason {
    if (kIsWeb) return 'Not available in the browser yet';
    if (googleServerClientId.isEmpty) {
      return 'Google Drive sync is not set up in this build';
    }
    return null;
  }

  @override
  bool get isAvailable => unavailableReason == null;

  Future<void> _ensureInitialized() =>
      _initialized ??= GoogleSignIn.instance.initialize(
        clientId: googleWebClientId.isEmpty ? null : googleWebClientId,
        serverClientId: googleServerClientId.isEmpty
            ? null
            : googleServerClientId,
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
