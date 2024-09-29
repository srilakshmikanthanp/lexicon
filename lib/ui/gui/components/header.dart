import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.header, this.onClick});

  final ValueSetter<String>? onClick;
  final String header;

  void _onClick() {
    onClick?.call(header);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
      ),
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
        onPressed: _onClick,
        child: Text(
          style: Theme.of(context).textTheme.headlineLarge,
          header,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
