import 'package:lexicon/type/definition.dart';

abstract class Dictionary {
  /// Define of the word as per Dictionary
  Definition define(String word);

  /// Lang of Dictionary
  String language;

  /// Constructor for Dictionary
  Dictionary(this.language);
}
