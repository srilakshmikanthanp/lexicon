import 'package:flutter/material.dart';
import 'package:lexicon/ui/gui/components/header.dart';
import 'package:lexicon/ui/gui/components/index.dart';
import 'package:lexicon/ui/gui/components/word.dart';
import 'package:lexicon/utility/extensions.dart';
import 'package:lexicon/utility/functions.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sticky_headers/sticky_headers.dart';

class Page extends StatefulWidget {
  final ValueSetter<String>? onWordClick;
  final List<String> words;

  const Page({
    super.key,
    required this.words,
    this.onWordClick,
  });

  @override
  State<StatefulWidget> createState() {
    return _Page();
  }
}

class _Page extends State<Page> {
  Future<List<String>> _preprocess(BuildContext ctx, List<String> words) async {
    var result = await Stream.fromIterable(words)
        .map((word) => word.toLowerCase())
        .asyncWhere((word) => filter(ctx, word))
        .toSet();

    return List<String>.from(result);
  }

  Map<String, List<String>> _group({
    required List<String> words,
    required String Function(String) map,
  }) {
    var result = <String, List<String>>{};

    for (var word in words) {
      result.putIfAbsent(map(word[0]), () => []).add(word);
    }

    for (var key in result.keys) {
      result[key]!.sort();
    }

    return result;
  }

  late ItemScrollController _itemScrollController;
  bool _isShowingIndex = false;

  @override
  void initState() {
    _itemScrollController = ItemScrollController();
    super.initState();
  }

  Widget _mainWidget(BuildContext ctx, AsyncSnapshot<List<String>> snapshot) {
    var items = _group(words: snapshot.data!, map: (w) => w[0].toUpperCase());
    var keys = items.keys.toList()..sort();

    Widget mapper(String value) {
      return Word(value: value, onClick: widget.onWordClick);
    }

    var list = ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: keys.length,
      itemBuilder: (context, index) {
        return StickyHeader(
          header: Header(
            onClick: (_) => setState(() {
              _isShowingIndex = true;
            }),
            header: keys[index],
          ),
          content: Column(
            children: [
              ...items[keys[index]]!.map(mapper),
            ],
          ),
        );
      },
    );

    void scrollToValue(String value) {
      _itemScrollController.scrollTo(
        duration: const Duration(seconds: 1),
        index: keys.indexOf(value),
        curve: Curves.easeInOut,
      );
    }

    var index = Index(
      onClick: (String value) async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          scrollToValue(value);
        });
        setState(() {
          _isShowingIndex = false;
        });
      },
      chars: keys,
    );

    return _isShowingIndex ? index : list;
  }

  Widget _errorWidget(BuildContext ctx, AsyncSnapshot<List<String>> snapshot) {
    return Column(
      children: <Widget>[
        const Icon(
          Icons.error_outline,
          color: Colors.red,
          size: 60,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text('${snapshot.error}'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _preprocess(context, widget.words),
      builder: (ctx, snapshot) {
        if (snapshot.hasError) {
          return _errorWidget(context, snapshot);
        }

        if (snapshot.hasData) {
          return _mainWidget(context, snapshot);
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
