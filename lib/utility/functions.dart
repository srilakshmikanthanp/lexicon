import 'dart:convert';
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:lexicon/constants/constants.dart';

/// Loads stops word for given Locale
Future<List<String>> loadStopWordsForLocale(Locale locale) async {
  final jsonData = await rootBundle.loadString(await appStopWordsAsset());
  final json = jsonDecode(jsonData) as Map<String, dynamic>;
  final langCode = locale.languageCode;

  if (!json.containsKey(langCode)) {
    throw Exception("$langCode not found");
  } else {
    return json[langCode];
  }
}
