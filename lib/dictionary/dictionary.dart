import 'dart:convert';
import 'dart:ui';

import 'package:http/http.dart' as http;
import 'package:lexicon/types/definition.dart';

abstract class Dictionary {
  /// Define of the word as per Dictionary
  Future<Definition> define(String word);

  /// Lang of Dictionary
  Locale locale;

  /// Constructor for Dictionary
  Dictionary(this.locale);

  /// Factory Method to create
  factory Dictionary.build(Locale locale) {
    return ApiDict(locale);
  }
}

/// An Implementation of Dictionary
class ApiDict extends Dictionary {
  List<Interpretation> _interpretation(List<dynamic> list) {
    List<Interpretation> interpretations = [];

    for (var entry in list) {
      var example = entry['example'];
      var def = entry['definition'];
      var args = Interpretation(interpretation: def, example: example);
      interpretations.add(args);
    }

    return interpretations;
  }

  List<Phonetic> _phonetics(List<dynamic> list) {
    List<Phonetic> phonetics = [];

    for (var entry in list) {
      var audioURI = entry['audio'];
      var text = entry['text'];
      phonetics.add(Phonetic(audioURI: audioURI, text: text));
    }

    return phonetics;
  }

  Meaning _meaning(List<dynamic> list) {
    var meaning = Meaning();

    for (var entry in list) {
      var interpretations = _interpretation(entry['definitions']);
      var partOfSpeech = entry['partOfSpeech'];
      meaning[partOfSpeech] = interpretations;
    }

    return meaning;
  }

  String _buildFetchUrl(String word) {
    return 'api/v2/entries/${locale.languageCode}/$word';
  }

  ApiDict(super.locale);

  @override
  Future<Definition> define(String word) async {
    const String host = 'api.dictionaryapi.dev';
    var fetchUrl = Uri.https(host, _buildFetchUrl(word));
    var res = await http.get(fetchUrl);
    var list = jsonDecode(res.body);
    var definition = Definition.empty(word: word);

    if(list is! List<dynamic>) {
      return definition;
    }

    for(var json in list) {
      final phonetics = json['phonetics'];
      final meanings = json['meanings'];

      if(phonetics != null) {
        definition.phonetics.addAll(_phonetics(phonetics));
      }

      if(meanings != null) {
        definition.meaning.addAll(_meaning(meanings));
      }
    }

    return definition;
  }
}
