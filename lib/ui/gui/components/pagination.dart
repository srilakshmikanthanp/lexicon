import 'package:flutter/material.dart';

class Pagination extends StatelessWidget {
  void Function()? _prevCallback() {
    if(now == start) {
      return null;
    }

    return _handlePrev;
  }

  void Function()? _nextCallback() {
    if(now == end) {
      return null;
    }

    return _handleNext;
  }

  const Pagination({
    super.key,
    required this.start,
    required this.end,
    required this.now,
    this.onPrev,
    this.onNext,
    this.onClick,
  });

  final ValueSetter<int>? onPrev;
  final ValueSetter<int>? onNext;
  final VoidCallback? onClick;
  final int now, start, end;

  void _handlePrev() {
    onPrev?.call(now - 1);
  }

  void _handleNext() {
    onNext?.call(now + 1);
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
            Icons.arrow_back_ios_new,
          ),
        ),
        GestureDetector(
          onTap: onClick,
          child: Row(
            children: [
              Text("$now"),
              const Text("/"),
              Text("$end"),
            ],
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            disabledIconColor: Colors.grey,
          ),
          onPressed: _nextCallback(),
          child: const Icon(
            Icons.arrow_forward_ios,
          ),
        ),
      ],
    );
  }
}
