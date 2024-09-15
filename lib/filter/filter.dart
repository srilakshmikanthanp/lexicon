import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:lexicon/constants/constants.dart';

abstract class Filter extends Stream<String> {
  /// Async Where implementation of where
  Stream<String> asyncWhere(Future<bool> Function(String) test) async* {
    await for (final element in this) {
      if (await test(element)) {
        yield element;
      }
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

  /// Load Json data from Assets
  Future<Map<String, dynamic>> _loadStopWords() async {
    final jsonData = await rootBundle.loadString(await appStopWordsAsset());
    return jsonDecode(jsonData) as Map<String, dynamic>;
  }

  /// Cache of stop words
  Map<String, dynamic>? stopWords;

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
    stopWords ??= await _loadStopWords();
    var lang = stopWords![locale.languageCode] as List<String>;
    return lang.contains(word);
  }
}
