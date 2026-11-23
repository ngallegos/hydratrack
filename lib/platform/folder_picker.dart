import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

abstract interface class FolderPicker {
  /// Returns the chosen directory path, or null if cancelled or not allowed.
  Future<String?> pickFolder();
}

class SystemFolderPicker implements FolderPicker {
  const SystemFolderPicker();

  @override
  Future<String?> pickFolder() async {
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      // Writing into an arbitrary folder (like a Syncthing share) needs
      // "all files access" on Android 11+.
      final status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) return null;
    }
    // pickDirectory() would give a content:// URI on Android, which dart:io
    // cannot read. With all-files access a real path works, so use it.
    // ignore: deprecated_member_use
    return FilePicker.getDirectoryPath(dialogTitle: 'Choose a sync folder');
  }
}
