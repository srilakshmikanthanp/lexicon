import 'package:flutter/material.dart';
import 'package:lexicon/ui/gui/components/scanner.dart';

class Scan extends StatelessWidget {
  final ValueSetter<List<String>>? onScanned;

  const Scan({super.key, this.onScanned});

  @override
  Widget build(BuildContext context) {
    const infoText = "Scan or Choose Images from gallery";

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Scanner(
          onScanned: onScanned,
        ),
        const Text(
          style: TextStyle(
            color: Colors.grey,
          ),
          infoText,
        ),
      ],
    );
  }
}
