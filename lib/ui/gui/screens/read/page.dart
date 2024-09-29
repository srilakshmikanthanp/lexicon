import 'package:flutter/material.dart';
import 'package:lexicon/ui/gui/components/header.dart';
import 'package:lexicon/ui/gui/components/word.dart';
import 'package:lexicon/utility/functions.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Page extends StatelessWidget {
  const Page({super.key, required this.words, this.onWordClick});

  final ValueSetter<String>? onWordClick;
  final List<String> words;

  Widget _mapper(String value) {
    return Word(value: value, onClick: onWordClick);
  }

  @override
  Widget build(BuildContext context) {
    var items = groupWords(words: words, map: (w) => w[0].toUpperCase());
    var keys = items.keys.toList()..sort();

    return ListView.builder(
      itemCount: keys.length,
      itemBuilder: (context, index) {
        return StickyHeader(
          header: Header(header: keys[index]),
          content: Column(
            children: [
              ...items[keys[index]]!.map(_mapper),
            ],
          ),
        );
      },
    );
  }
}
