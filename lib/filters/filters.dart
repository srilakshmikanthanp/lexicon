import 'dart:async';
import 'dart:ui';

import 'package:lexicon/utility/functions.dart';

abstract class Filters {
  /// Returns the word is Stop word or not
  Future<bool> isStopWord(String word);

  /// Constructor
  Filters(this.locale);

  /// Locale Used
  Locale locale;

  /// Builder for Filter class
  factory Filters.build(Locale locale) {
    return JsonFilters(locale);
  }
}

/// An Filter Implementation
class JsonFilters extends Filters {
  /// Cache of stop words
  List<String>? stopWords;

  /// Constructor
  JsonFilters(super.locale);

  /// Is Stop Word
  @override
  Future<bool> isStopWord(String word) async {
    stopWords ??= await loadStopWordsForLocale(locale);
    return stopWords!.contains(word);
  }
}
