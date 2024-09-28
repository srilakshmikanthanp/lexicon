import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  void Function()? _prevCallback() {
    if(current == start) {
      return null;
    }

    return _handlePrev;
  }

  void Function()? _nextCallback() {
    if(current == end) {
      return null;
    }

    return _handleNext;
  }

  const Pagination({
    super.key,
    required this.start,
    required this.end,
    required this.current,
    this.onPrev,
    this.onNext,
  });

  final ValueSetter<int>? onPrev;
  final ValueSetter<int>? onNext;
  final int current, start, end;

  void _handlePrev() {
    onPrev?.call(current - 1);
  }

  void _handleNext() {
    onNext?.call(current + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          style: TextButton.styleFrom(
            disabledIconColor: Colors.grey,
          ),
          onPressed: _prevCallback(),
          child: const Icon(
            Icons.arrow_left,
          ),
        ),
        Text("$current"),
        TextButton(
          style: TextButton.styleFrom(
            disabledIconColor: Colors.grey,
          ),
          onPressed: _nextCallback(),
          child: const Icon(
            Icons.arrow_right,
          ),
        ),
      ],
    );
  }
}
