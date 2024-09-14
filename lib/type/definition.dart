class Definition {
  final Map<String, List<Interpretation>> _meanings = {};
  final List<Phonetic> _phonetics = [];

  List<Interpretation> getInterpretation(String pos) {
    return List.unmodifiable(_meanings[pos] ?? []);
  }

  Map<String, List<Interpretation>> getMeanings() {
    return Map.unmodifiable(_meanings);
  }

  void addInterpretation(String pos, Interpretation interpretation) {
    _meanings.putIfAbsent(pos, () => []).add(interpretation);
  }

  void addPhonetic(Phonetic phonetic) {
    _phonetics.add(phonetic);
  }

  List<Phonetic> getPhonetics() {
    return List.unmodifiable(_phonetics);
  }

  List<String> getPartOfSpeeches() {
    return _meanings.keys.toList();
  }
}

class Interpretation {
  final String interpretation;
  final String? example;

  Interpretation({
    required this.interpretation,
    required this.example
  });
}

class Phonetic {
  final String? audioURI;
  final String text;

  Phonetic({
    required this.audioURI,
    required this.text
  });
}
