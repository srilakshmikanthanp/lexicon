import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:lexicon/constants/constants.dart';

abstract class Filters {
  /// Returns the word is Empty word or not
  Future<bool> isEmptyWord(String word) async {
    return word.replaceAll(" ", "").isEmpty;
  }

  /// Returns if it is a not word like symbols
  Future<bool> isNonWord(String word) async {
    RegExp regex = RegExp(r'[^\p{L}]', unicode: true);
    return regex.hasMatch(word);
  }

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
  Future<List<String>?> _loadStopWordsForLocale(Locale locale) async {
    final jsonData = await rootBundle.loadString(Constants.appStopWordsAsset);
    final json = jsonDecode(jsonData) as Map<String, dynamic>;
    final langCode = locale.languageCode;

    if (!json.containsKey(langCode)) {
      throw Exception("$langCode not found in Stop Words Json");
    } else {
      return List<String>.from(json[langCode]);
    }
  }

  /// static instance of cache
  static Map<Locale, List<String>?> stopWords = {};

  /// Constructor
  JsonFilters(super.locale);

  /// Is Stop Word
  @override
  Future<bool> isStopWord(String word) async {
    if(!stopWords.containsKey(locale)) {
      stopWords[locale] = await _loadStopWordsForLocale(locale);
    }

    return stopWords[locale]!.contains(word.toLowerCase());
  }
}
