import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

/// Get the Asset As File
Future<File> getAssetAsFile(String assetPath) async {
  // Load the asset as a byte array
  final byteData = await rootBundle.load(assetPath);

  // Get the File Extension
  final ext = path.extension(assetPath);

  // Get the current Time
  final now = DateTime.now().millisecondsSinceEpoch;

  // Get the temporary directory to store the file
  final tempDir = await getTemporaryDirectory();

  // Create a file in the temporary directory
  final tempFile = File('${tempDir.path}/$now.$ext');

  // Write the byte data to the file
  await tempFile.writeAsBytes(byteData.buffer.asUint8List());

  // Return the File Loaded
  return tempFile;
}

/// Groups words, Don't pass empty words
Map<String, List<String>> groupWords({
  required List<String> words,
  required String Function(String) map,
}) {
  var result = <String, List<String>>{};

  for(var word in words) {
    result.putIfAbsent(map(word[0]), () => []).add(word);
  }

  for(var key in result.keys) {
    result[key]!.sort();
  }

  return result;
}
