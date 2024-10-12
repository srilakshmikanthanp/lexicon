import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  const Index({super.key, required this.chars, required this.onClick});

  final ValueSetter<String> onClick;
  final List<String> chars;

  @override
  Widget build(BuildContext context) {
    Widget clickable(String char) {
      return TextButton(
        onPressed: () => onClick(char),
        child: Text(
          char,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      );
    }

    return GridView.count(
      padding: const EdgeInsets.all(5),
      crossAxisCount: 4,
      children: List.generate(chars.length, (index) {
        return Center(
          child: clickable(chars[index]),
        );
      }),
    );
  }
}
