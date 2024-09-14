import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:lexicon/dictionary/dictionary.dart';
import 'package:lexicon/type/definition.dart';

class FreeDict extends Dictionary {
  List<Interpretation> _interpretation(List<Map<String, dynamic>> list) {
    List<Interpretation> interpretations = [];

    for (var entry in list) {
      var example = entry['example'];
      var def = entry['definition'];
      var args = Interpretation(interpretation: def, example: example);
      interpretations.add(args);
    }

    return interpretations;
  }

  List<Phonetic> _phonetics(List<Map<String, dynamic>> list) {
    List<Phonetic> phonetics = [];

    for (var entry in list) {
      var audioURI = entry['audio'];
      var text = entry['text'];
      phonetics.add(Phonetic(audioURI: audioURI, text: text));
    }

    return phonetics;
  }

  Meaning _meaning(List<Map<String, dynamic>> list) {
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

  FreeDict(super.locale);

  @override
  Future<Definition> define(String word) async {
    const String host = 'https://api.dictionaryapi.dev';
    var fetchUrl = Uri.http(host, _buildFetchUrl(word));
    var res = await http.get(fetchUrl);
    var json = jsonDecode(res.body) as Map<String, dynamic>;
    var phonetics = json['phonetics'];
    var meanings = json['meanings'];

    return Definition(
      phonetics: _phonetics(phonetics),
      word: word,
      meaning: _meaning(meanings)
    );
  }
}
