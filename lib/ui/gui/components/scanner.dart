import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:lexicon/ocr/ocr.dart';
import 'package:lexicon/ui/gui/components/picker.dart';

class Scanner extends StatefulWidget {
  final ValueSetter<List<String>>? onScanned;
  final Ocr ocr = Ocr.build();

  Scanner({
    super.key,
    this.onScanned,
  });

  @override
  State<StatefulWidget> createState() {
    return _Scanner();
  }
}

class _Scanner extends State<Scanner> {
  Future<void> _processImages(List<XFile> images) async {
    List<String> words = [];

    for (var img in images) {
      words.addAll(await widget.ocr.processImage(img));
    }

    widget.onScanned?.call(words);
  }

  void _handlePicked(List<XFile> images) {
    setState(() { isLoading = true; });
    _processImages(images).then((_) {
      setState(() {
        isLoading = false;
      });
    });
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(16),
      child: isLoading
          ? const CircularProgressIndicator()
          : Picker(onPicked: _handlePicked),
    );
  }
}
