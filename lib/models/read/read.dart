import 'package:flutter/cupertino.dart';

class Read with ChangeNotifier {
  /// Pages State
  final List<List<String>> _pages = [];

  void merge(int index, List<String> page) {
    _pages[index].addAll(page);
    notifyListeners();
  }

  void addPage(List<String> page) {
    _pages.add(page);
    notifyListeners();
  }

  void delete(int index) {
    _pages.removeAt(index);
    notifyListeners();
  }

  List<String> getPage(int index) {
    return List.unmodifiable(_pages[index]);
  }

  /// Search State
  String _search = "";

  String get search {
    return _search;
  }

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  /// Pagination state
  final int start = 0;

  int _now = 0;

  int get now => _now;

  set now(int value) {
    _now = value;
    notifyListeners();
  }

  int get end {
    return _pages.length;
  }
}
