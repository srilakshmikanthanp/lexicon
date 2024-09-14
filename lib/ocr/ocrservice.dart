import 'package:image_picker/image_picker.dart';
import 'package:lexicon/ocr/ocrgooglemlkit.dart';

abstract class OcrService {
  /// Extract the Words from the Image
  Future<List<String>> processImage(XFile image);

  /// Constructor
  OcrService();

  /// Factory Method to create
  factory OcrService.build() {
    return OcrGoogleMlKit();
  }
}
