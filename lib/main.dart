import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lexicon/ui/gui/components/picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example Image',
      home: Scaffold(
          appBar: AppBar(
            title: Text("Example"),
          ),
          body: Center(
            child: Picker(onPicked: (files) => {log(files.length.toString())},),
          )),
    );
  }
}
