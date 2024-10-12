import 'package:flutter/material.dart';
import 'package:lexicon/dictionary/dictionary.dart';
import 'package:lexicon/settings/settings.dart';
import 'package:lexicon/types/definition.dart' as types;
import 'package:provider/provider.dart';

class _EmptyDefinition extends StatelessWidget {
  final ValueSetter<String>? onSearch;
  final String word;

  const _EmptyDefinition({
    required this.word,
    this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ElevatedButton.styleFrom(
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(20),
    );

    final button = ElevatedButton(
      onPressed: () => onSearch?.call(word),
      style: buttonStyle,
      child: const Icon(Icons.language),
    );

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        const Text("Sorry We Couldn't found meaning!"),
        button,
      ],
    );
  }
}

class _Interpretation extends StatelessWidget {
  Widget _definition(BuildContext context) {
    return Text(
      style: Theme.of(context).textTheme.titleMedium,
      textAlign: TextAlign.left,
      "\u2022 ${interpretation.interpretation}",
    );
  }

  Widget _example(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;

    if (interpretation.example == null) {
      return const SizedBox.shrink();
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(),
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        style: bodyMedium,
        interpretation.example!,
      ),
    );
  }

  final types.Interpretation interpretation;

  const _Interpretation({
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _definition(context),
        _example(context),
      ],
    );
  }
}

class _Meaning extends StatelessWidget {
  final List<types.Interpretation> interpretations;
  final String partOfSpeech;

  Widget get _interpretations {
    final widgets = interpretations.map((entry) {
      return _Interpretation(interpretation: entry);
    }).toList();

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: widgets.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return widgets[index];
      },
    );
  }

  const _Meaning({
    required this.interpretations,
    required this.partOfSpeech,
  });

  @override
  Widget build(BuildContext context) {
    final partOfSpeech = Text(
      style: Theme.of(context).textTheme.labelLarge,
      textAlign: TextAlign.left,
      this.partOfSpeech,
    );

    final content = Padding(
      padding: const EdgeInsets.only(left: 4),
      child: _interpretations,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [partOfSpeech, content],
    );
  }
}

class Definition extends StatefulWidget {
  final ValueSetter<String>? onSearch;
  final String word;

  const Definition({
    super.key,
    this.onSearch,
    required this.word,
  });

  @override
  State<StatefulWidget> createState() {
    return _Definition();
  }
}

class _Definition extends State<Definition> {
  Widget _getMeanings(BuildContext context, types.Definition definition) {
    final partOfSpeeches = definition.meaning.keys.toList()..sort();
    final meanings = partOfSpeeches.map((entry) {
      return _Meaning(
        interpretations: definition.meaning[entry]!,
        partOfSpeech: entry,
      );
    }).toList();

    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: meanings.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return meanings[index];
      },
    );
  }

  Future<types.Definition> _fetchDefinition(
    BuildContext context,
    String word,
  ) async {
    final settings = Provider.of<Settings>(context);
    final dict = Dictionary.build(Locale(settings.language));
    return await dict.define(word);
  }

  Widget _mainWidget(
    BuildContext context,
    AsyncSnapshot<types.Definition> definition,
  ) {
    if (definition.data!.isEmpty()) {
      return _EmptyDefinition(
        word: definition.data!.word,
        onSearch: widget.onSearch,
      );
    }

    final word = Text(
      style: Theme.of(context).textTheme.headlineMedium,
      textAlign: TextAlign.left,
      definition.data!.word,
    );

    final meanings = _getMeanings(
      context,
      definition.data!,
    );

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [word, const Divider(), meanings],
      ),
    );
  }

  Widget _errorWidget(
    BuildContext ctx,
    AsyncSnapshot<types.Definition> snapshot,
  ) {
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
    return FutureBuilder<types.Definition>(
      future: _fetchDefinition(context, widget.word),
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
