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
    return Container(
      margin: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            alignment: Alignment.centerLeft,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: _onClick,
          child: Text(
            value,
            textAlign: TextAlign.left,
          ),
        ),
      ),
    );
  }
}
