import 'package:flutter/material.dart';

class Word extends StatelessWidget {
  const Word({super.key, required this.value, this.onClick});

  final ValueSetter<String>? onClick;
  final String value;

  void _onClick() {
    onClick?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
        onPressed: _onClick,
        child: Text(
          style: Theme.of(context).textTheme.titleMedium,
          value,
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
