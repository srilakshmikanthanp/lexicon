import 'package:flutter/cupertino.dart';

class Read with ChangeNotifier {
  /// Pages State
  final List<List<String>> _pages;

  void mergeToPage(int index, List<String> page) {
    _pages[index].addAll(page);
    notifyListeners();
  }

  void addPage(List<String> page) {
    _pages.add(page);
    notifyListeners();
  }

  void deletePage(int index) {
    _pages.removeAt(index);
    notifyListeners();
  }

  void deleteAllPages() {
    _pages.clear();
    notifyListeners();
  }

  List<String> getPage(int index) {
    return List.unmodifiable(_pages[index]);
  }

  /// Pagination state
  final int start;

  int _now;

  int get now => _now;

  set now(int value) {
    _now = value;
    notifyListeners();
  }

  void goPrev() {
    if(_now == 0) {
      throw Exception("Now is Already Zero");
    }

    _now--;

    notifyListeners();
  }

  void goNext() {
    if(_now == end) {
      throw Exception("Now is Already End");
    }

    _now++;

    notifyListeners();
  }

  void goStart() {
    _now = 0;
    notifyListeners();
  }

  void goEnd() {
    _now = end;
    notifyListeners();
  }

  int get end {
    return _pages.length;
  }

  /// Empty Constructor
  Read.empty(): _pages = [], start = 0, _now = 0;

  /// Init Fields
  Read({
    required List<List<String>> pages,
    required this.start,
    required int now
  }): _pages = pages, _now = now;
}
