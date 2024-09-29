import 'package:flutter/cupertino.dart';

typedef Page = List<String>;

class Read extends ChangeNotifier {
  /// Pages State
  final List<Page> _pages = [];

  List<Page> get pages {
    return List.unmodifiable(_pages);
  }

  void addPage(Page page) {
    _pages.add(page);
    notifyListeners();
  }

  /// Search State
  String _search = "";

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  /// Pagination state
  final int _start = 0;
  int _now = 0;

  int get start => _start;

  int get now => _now;

  set now(int value) {
    _now = value;
    notifyListeners();
  }

  int get end {
    return _pages.length;
  }
}
