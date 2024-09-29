import 'package:flutter/material.dart';
import 'package:lexicon/filters/filters.dart';
import 'package:lexicon/models/read.dart' as models;
import 'package:lexicon/settings/settings.dart';
import 'package:lexicon/ui/gui/components/pagination.dart';
import 'package:lexicon/ui/gui/components/scanner.dart';
import 'package:lexicon/ui/gui/screens/read/page.dart' as ui;
import 'package:lexicon/utility/extensions.dart';
import 'package:provider/provider.dart';

class Read extends StatelessWidget {
  Future<void> _onScanned(
    BuildContext ctx,
    List<String> words,
    models.Read read,
  ) async {
    Future<bool> canTakeWord(BuildContext ctx, String word) async {
      var settings = Provider.of<Settings>(ctx, listen: false);
      var filters = Filters.build(Locale(settings.language));
      if (settings.canFilterWords && await filters.isStopWord(word)) {
        return false;
      } else if (await filters.isEmptyWord(word)) {
        return false;
      } else if (await filters.isNonWord(word)) {
        return false;
      } else {
        return true;
      }
    }

    var result = await Stream.fromIterable(words)
        .map((word) => word.toLowerCase())
        .asyncWhere((word) => canTakeWord(ctx, word))
        .toSet();

    return read.addPage(models.Page.from(result));
  }

  const Read({super.key});

  Widget _getWidget(models.Read read) {
    var scanner = Consumer<models.Read>(builder: (ctx, read, child) {
      return Scanner(onScanned: (res) async => _onScanned(ctx, res, read));
    });

    var text = const Text(
      style: TextStyle(color: Colors.grey),
      "Scan or Choose Images from gallery",
    );

    if (read.now != read.end) {
      return ui.Page(
        words: read.pages[read.now],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        scanner,
        text,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final searchBar = Consumer<models.Read>(
      builder: (context, read, child) {
        return SearchBar(
          onChanged: (value) => read.search = value,
          hintText: 'Search Word',
          leading: const Icon(
            Icons.search_rounded,
          ),
        );
      },
    );

    final pagination = Consumer<models.Read>(
      builder: (context, read, child) {
        return Pagination(
          onPrev: (now) => read.now = now,
          onNext: (now) => read.now = now,
          start: read.start,
          end: read.end,
          now: read.now,
        );
      },
    );

    final widget = Consumer<models.Read>(
      builder: (ctx, read, child) {
        return _getWidget(read);
      },
    );

    final items = [
      const SizedBox(height: 30),
      searchBar,
      const SizedBox(height: 30),
      Expanded(child: widget),
      const SizedBox(height: 10),
      pagination,
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: items,
      ),
    );
  }
}
