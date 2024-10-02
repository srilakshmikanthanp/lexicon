import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lexicon/models/read/read.dart' as models;
import 'package:lexicon/ui/gui/components/pagination.dart';
import 'package:lexicon/ui/gui/components/scanner.dart';
import 'package:lexicon/ui/gui/dialogs/dialogs.dart';
import 'package:lexicon/ui/gui/screens/read/page.dart' as ui;
import 'package:provider/provider.dart';

class Read extends StatelessWidget {
  Future<void> _onScanned(List<String> words, models.Read read) async {
    return read.addPage(List<String>.from(words));
  }

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
          read.merge(read.now, page);
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
          read.delete(read.now);
        }
      },
    );

    var actionSheet = CupertinoActionSheet(
      actions: [actionAddMore, actionDelete],
    );

    showCupertinoModalPopup(
      context: context,
      builder: (context) => actionSheet,
    );
  }

  const Read({super.key});

  Widget _getWidget(BuildContext context, models.Read read) {
    var scanner = Scanner(onScanned: (res) async => _onScanned(res, read));

    var text = const Text(
      style: TextStyle(color: Colors.grey),
      "Scan or Choose Images from gallery",
    );

    if (read.now != read.end) {
      return ui.Page(
        words: read.getPage(read.now),
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
      builder: (ctx, read, child) {
        return Pagination(
          onPrev: (now) => read.now = now,
          onNext: (now) => read.now = now,
          start: read.start,
          end: read.end,
          now: read.now,
          onClick: read.now != read.end ? () => _onPageClick(ctx, read) : null,
        );
      },
    );

    final widget = Consumer<models.Read>(
      builder: (ctx, read, child) {
        return _getWidget(context, read);
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
