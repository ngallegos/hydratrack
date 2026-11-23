import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

abstract interface class FileTransfer {
  /// Asks where to save [text]. Returns false if the user cancelled.
  Future<bool> saveText({
    required String fileName,
    required String text,
    required String mimeType,
  });

  /// Lets the user pick a file and returns its text, or null if cancelled.
  Future<String?> pickText({required List<String> extensions});
}

class SystemFileTransfer implements FileTransfer {
  const SystemFileTransfer();

  @override
  Future<bool> saveText({
    required String fileName,
    required String text,
    required String mimeType,
  }) async {
    final saved = await FilePicker.saveFile(
      fileName: fileName,
      bytes: Uint8List.fromList(utf8.encode(text)),
      mimeType: mimeType,
    );
    return saved != null;
  }

  @override
  Future<String?> pickText({required List<String> extensions}) async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: extensions,
    );
    if (file == null) return null;
    return utf8.decode(await file.readAsBytes());
  }
}
