class Phrase {
  final String dari;
  final String phonetic;
  final String english;
  final String category;
  final String difficulty;

  const Phrase({
    required this.dari,
    required this.phonetic,
    required this.english,
    required this.category,
    required this.difficulty,
  });
}

class PhraseCategory {
  final String id;
  final String name;
  final String dariName;
  final String icon;
  final List<Phrase> phrases;

  const PhraseCategory({
    required this.id,
    required this.name,
    required this.dariName,
    required this.icon,
    required this.phrases,
  });
}
