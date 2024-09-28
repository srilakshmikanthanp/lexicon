import 'package:flutter/material.dart';
import 'package:lexicon/ui/gui/components/pagination.dart';
import 'package:lexicon/ui/gui/sections/page.dart' as lexicon;
import 'package:lexicon/ui/gui/sections/scan.dart';

class Read extends StatefulWidget {
  const Read({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Read();
  }
}

class _Read extends State<Read> {
  void _handleScannedWords(List<String> words) {}

  void _handlePrevPage(int current) {
    setState(() {
      _current = current;
    });
  }

  void _handleNextPage(int current) {
    setState(() {
      _current = current;
    });
  }

  void _handleSearch(String value) {
    setState(() {
      _search = value;
    });
  }

  final List<lexicon.Page> _pages = [];
  String _search = "";
  int _current = 0;

  Widget get _widget {
    if (_current == _end) {
      return Scan(onScanned: _handleScannedWords);
    } else {
      return _pages[_current];
    }
  }

  int get _start {
    return 0;
  }

  int get _end {
    return _pages.length;
  }

  @override
  Widget build(BuildContext context) {
    final searchBar = Padding(
      padding: const EdgeInsets.all(16),
      child: SearchBar(
        onChanged: _handleSearch,
        hintText: 'Search Word',
        leading: const Icon(
          Icons.search_rounded,
        ),
      ),
    );

    final pagination = Pagination(
      onPrev: _handlePrevPage,
      onNext: _handleNextPage,
      start: _start,
      end: _end,
      current: _current,
    );

    final items = [
      const SizedBox(height: 30),
      searchBar,
      const SizedBox(height: 30),
      Expanded(child: _widget),
      const SizedBox(height: 10),
      pagination,
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: items,
        ),
      ),
    );
  }
}
