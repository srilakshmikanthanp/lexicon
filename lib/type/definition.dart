import 'dart:collection';

class Interpretation {
  final String interpretation;
  final String? example;

  Interpretation({
    required this.interpretation,
    required this.example
  });
}

class Meaning extends MapMixin<String, List<Interpretation>> {
  final Map<String, List<Interpretation>> _map = {};

  void addInterpretation(String pos, Interpretation interpretation) {
    _map.putIfAbsent(pos, () => []).add(interpretation);
  }

  List<Interpretation> getInterpretations(String pos) {
    return List.unmodifiable(_map[pos] ?? []);
  }

  List<String> getPartOfSpeeches() {
    return _map.keys.toList();
  }

  @override
  List<Interpretation>? operator [](Object? key) {
    return _map[key];
  }

  @override
  void operator []=(String key, List<Interpretation> value) {
    _map[key] = value;
  }

  @override
  void clear() {
    _map.clear();
  }

  @override
  Iterable<String> get keys => _map.keys;

  @override
  List<Interpretation>? remove(Object? key) {
    return _map.remove(key);
  }
}

class Phonetic {
  final String? audioURI;
  final String? text;

  Phonetic({
    required this.audioURI,
    required this.text
  });
}

class Definition {
  List<Phonetic> phonetics = [];
  Meaning meaning = Meaning();
  final String word;

  Definition.empty ({
    required this.word,
  });

  Definition({
    required this.phonetics,
    required this.word,
    required this.meaning,
  });
}
