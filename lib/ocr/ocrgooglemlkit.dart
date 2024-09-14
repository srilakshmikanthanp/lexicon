import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lexicon/ocr/ocrservice.dart';

class OcrGoogleMlKit extends OcrService {
  static final Finalizer<OcrGoogleMlKit> _finalizer = Finalizer(_finalize);
  final TextRecognizer _textRecognizer = TextRecognizer();

  static void _finalize(OcrGoogleMlKit ocr) {
    ocr._textRecognizer.close();
    _finalizer.detach(ocr);
  }

  OcrGoogleMlKit() {
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
