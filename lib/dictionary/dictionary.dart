import 'dart:ui';

import 'package:lexicon/dictionary/freedict.dart';
import 'package:lexicon/type/definition.dart';

abstract class Dictionary {
  /// Define of the word as per Dictionary
  Future<Definition> define(String word);

  /// Lang of Dictionary
  Locale locale;

  /// Constructor for Dictionary
  Dictionary(this.locale);

  /// Factory Method to create
  factory Dictionary.build(Locale locale) {
    return FreeDict(locale);
  }
}
