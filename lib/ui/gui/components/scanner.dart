import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:lexicon/ocr/ocr.dart';
import 'package:lexicon/ui/gui/components/picker.dart';

class Scanner extends StatefulWidget {
  final ValueSetter<List<String>>? onScanned;
  final Ocr ocr = Ocr.build();
  final Widget? child;

  Scanner({
    super.key,
    this.onScanned,
    this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return _Scanner();
  }
}

class _Scanner extends State<Scanner> {
  Future<void> _handlePicked(List<XFile> images) async {
    List<String> words = [];

    setState(() {
      isProcessing = true;
    });

    for (var img in images) {
      words.addAll(await widget.ocr.processImage(img));
    }

    widget.onScanned?.call(words);

    setState(() {
      isProcessing = false;
    });
  }

  bool isProcessing = false;

  @override
  Widget build(BuildContext context) {
    var progress = const CircularProgressIndicator();
    var picker = Picker(
      onPicked: (values) async => _handlePicked(values),
      child: widget.child,
    );

    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(16),
      child: isProcessing ? progress : picker,
    );
  }
}
