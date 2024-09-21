import 'dart:io';

import 'package:cross_file/cross_file.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

abstract class Ocr {
  /// Extract the Words from the Image
  Future<List<String>> processImage(XFile image);

  /// Constructor
  Ocr();

  /// Factory Method to create
  factory Ocr.build() {
    return MlKitOcr();
  }
}

/// An ocr implementation
class MlKitOcr extends Ocr {
  static final Finalizer<TextRecognizer> _finalizer = Finalizer(_finalize);
  final TextRecognizer _textRecognizer = TextRecognizer();

  static void _finalize(TextRecognizer engine) {
    engine.close().then((_) => _finalizer.detach(engine));
  }

  MlKitOcr() {
    _finalizer.attach(this, _textRecognizer, detach: this);
  }

  @override
  Future<List<String>> processImage(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final recognizedText = await _textRecognizer.processImage(inputImage);
    final List<String> result = [];

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (var word in line.elements) {
          result.add(word.text);
        }
      }
    }

    return result;
  }
}
