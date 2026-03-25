class AlphabetLetter {
  final String symbol;
  final String name;
  final String sound;
  final String example;
  final String audioFile;
  final bool mastered;

  const AlphabetLetter({
    required this.symbol,
    required this.name,
    required this.sound,
    required this.example,
    required this.audioFile,
    this.mastered = false,
  });
}