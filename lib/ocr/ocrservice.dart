import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

abstract class OcrService {
  /// Extract the Words from the Image
  Future<List<String>> processImage(XFile image);

  /// Constructor
  OcrService();

  /// Factory Method to create
  factory OcrService.build() {
    return _OcrMlKit();
  }
}

/// An ocr implementation
class _OcrMlKit extends OcrService {
  static final Finalizer<_OcrMlKit> _finalizer = Finalizer(_finalize);
  final TextRecognizer _textRecognizer = TextRecognizer();

  static void _finalize(_OcrMlKit ocr) {
    ocr._textRecognizer.close();
    _finalizer.detach(ocr);
  }

  _OcrMlKit() {
    _finalizer.attach(this, this, detach: this);
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
