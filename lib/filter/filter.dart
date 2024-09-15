import 'dart:async';
import 'dart:ui';

import 'package:lexicon/utility/functions.dart';

abstract class Filter extends Stream<String> {
  /// Async Where implementation of where
  Stream<String> asyncWhere(Future<bool> Function(String) test) async* {
    await for (final word in this) {
      if (await test(word)) yield word;
    }
  }

  /// Removes the stop word from Stream
  Stream<String> removeStopWords() {
    return asyncWhere((word) async => ! await isStopWord(word));
  }

  /// Constructor
  Filter(this.locale);

  /// Locale Used
  Locale locale;

  /// Returns the word is Stop word or not
  Future<bool> isStopWord(String word);

  /// Builder for Filter class
  factory Filter.build(Locale locale) {
    return _Filter(locale);
  }
}

/// An Filter Implementation
class _Filter extends Filter {
  /// an Stream Controller used in Filter
  final StreamController<String> _controller = StreamController<String>();

  /// Cache of stop words
  List<String>? stopWords;

  /// Constructor
  _Filter(super.locale);

  /// Override listen method
  @override
  StreamSubscription<String> listen(void Function(String event)? onData, {
    Function? onError, void Function()? onDone, bool? cancelOnError
  }) {
    return _controller.stream.listen(onData,
      onError: onError, onDone: onDone, cancelOnError: cancelOnError
    );
  }

  /// Is Stop Word
  @override
  Future<bool> isStopWord(String word) async {
    stopWords ??= await loadStopWordsForLocale(locale);
    return stopWords!.contains(word);
  }
}
