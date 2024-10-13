import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexicon/models/read/read.dart' as models;
import 'package:lexicon/ui/gui/components/definition.dart';
import 'package:lexicon/ui/gui/components/pagination.dart';
import 'package:lexicon/ui/gui/components/scanner.dart';
import 'package:lexicon/ui/gui/components/word.dart';
import 'package:lexicon/ui/gui/dialogs/dialogs.dart';
import 'package:lexicon/ui/gui/screens/read/page.dart' as ui;
import 'package:lexicon/utility/extensions.dart';
import 'package:lexicon/utility/functions.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class Read extends StatelessWidget {
  void _onPageClick(BuildContext context, models.Read read) {
    var actionAddMore = CupertinoActionSheetAction(
      child: const Text('Add more'),
      onPressed: () async {
        // close the options modal
        Navigator.of(context).pop();

        // get words
        var page = await showScanDialog(context);

        // add words
        if (page != null) {
          read.mergeToPage(read.now, page);
        }
      },
    );

    var actionDelete = CupertinoActionSheetAction(
      child: const Text('Delete'),
      onPressed: () async {
        // close the options modal
        Navigator.of(context).pop();

        var result = await showYesOrNoDialog(
          context,
          "Want to delete this Page",
        );

        if (result) {
          read
            ..goPrev()
            ..deletePage(read.now);
        }
      },
    );

    var actionDeleteAll = CupertinoActionSheetAction(
      child: const Text('Delete All'),
      onPressed: () async {
        // close the options modal
        Navigator.of(context).pop();

        var result = await showYesOrNoDialog(
          context,
          "Want to delete All Pages",
        );

        if (result) {
          read
            ..goStart()
            ..deleteAllPages();
        }
      },
    );

    var actionSheet = CupertinoActionSheet(
      actions: [actionAddMore, actionDelete, actionDeleteAll],
    );

    showCupertinoModalPopup(
      context: context,
      builder: (context) => actionSheet,
    );
  }

  void _onWordClick(BuildContext context, String word) {
    showModalBottomSheet<void>(
      constraints: const BoxConstraints.expand(),
      enableDrag: false,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Definition(
            onSearch: (word) => _searchWeb(word),
            word: word,
          ),
        );
      },
    );
  }

  Future<void> _searchWeb(String query) async {
    await launchUrl(Uri.parse('https://www.google.com/search?q=$query'));
  }

  const Read({super.key});

  Widget _buildSearchBar(BuildContext context, SearchController controller) {
    return SearchBar(
      padding: const WidgetStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: 16),
      ),
      onTap: () => controller.openView(),
      controller: controller,
      hintText: 'Search Word',
      onChanged: (value) => controller.openView(),
      leading: const Icon(
        Icons.search_rounded,
      ),
    );
  }

  Future<List<ListTile>> _suggestions(
    BuildContext ctx,
    SearchController controller,
    models.Read read,
  ) async {
    Future<bool> doFilter(String word) async {
      return word.contains(controller.value.text) && await filter(ctx, word);
    }

    final unique = await Stream.fromIterable(read.getPage(read.now))
        .map((word) => word.toLowerCase())
        .asyncWhere((word) => doFilter(word))
        .toSet();

    final words = unique.toList()..sort();

    return words.map((word) {
      return ListTile(
        title: Word(
          onClick: (word) => _onWordClick(ctx, word),
          value: word,
        ),
      );
    }).toList();
  }

  Widget _getPage(BuildContext context) {
    final models.Read read = Provider.of<models.Read>(context);

    final searchAnchor = SearchAnchor(
      suggestionsBuilder: (ctx, ct) => _suggestions(ctx, ct, read),
      builder: _buildSearchBar,
    );

    const box = SizedBox(
      height: 30,
    );

    final page = ui.Page(
      onWordClick: (word) => _onWordClick(context, word),
      words: read.getPage(read.now),
    );

    return Column(
      children: [searchAnchor, box, Expanded(child: page)],
    );
  }

  Widget _getWidget(BuildContext context) {
    final models.Read read = Provider.of<models.Read>(context);

    final scanner = Scanner(
      onScanned: (res) async => read.addPage(List<String>.from(res)),
    );

    var text = const Text(
      style: TextStyle(color: Colors.grey),
      "Scan or Choose Images from gallery",
    );

    if (read.now != read.end) {
      return _getPage(context);
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
    final pagination = Consumer<models.Read>(
      builder: (ctx, read, child) {
        return Pagination(
          onPrev: (now) => read.goPrev(),
          onNext: (now) => read.goNext(),
          start: read.start,
          end: read.end,
          now: read.now,
          onClick: read.now != read.end ? () => _onPageClick(ctx, read) : null,
        );
      },
    );

    final items = [
      const SizedBox(height: 30),
      Expanded(child: _getWidget(context)),
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
