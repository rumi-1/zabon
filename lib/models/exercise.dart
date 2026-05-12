enum ExerciseType {
  vocabIntro,
  mcqDariToEnglish,
  mcqEnglishToDari,
  fillBlank,
  matching,
  trueFalse,
  wordBank, // New exercise type
  dragDropSentence, // New drag and drop exercise type
}

class Exercise {
  final ExerciseType type;

  final String? prompt;
  final String? dari;
  final String? phonetic;
  final String? english;
  final String? correct;
  final List<String>? options;

  final List<VocabWord>? words;

  final List<String>? sentenceParts;
  final String? blankAnswer;
  final List<String>? altAnswers;

  final List<MatchingPair>? pairs;

  final String? statementDari;
  final String? statementEnglish;
  final bool? answer;

  // Word bank exercise fields
  final List<String>? wordBank;
  final String? targetSentence;

  // Drag and drop sentence fields
  final List<String>? dragSentenceParts;
  final List<String>? dragWords;
  final List<String>? correctOrder;

  const Exercise({
    required this.type,
    this.prompt,
    this.dari,
    this.phonetic,
    this.english,
    this.correct,
    this.options,
    this.words,
    this.sentenceParts,
    this.blankAnswer,
    this.altAnswers,
    this.pairs,
    this.statementDari,
    this.statementEnglish,
    this.answer,
    this.wordBank,
    this.targetSentence,
    this.dragSentenceParts,
    this.dragWords,
    this.correctOrder,
  });
}

class VocabWord {
  final String dari;
  final String phonetic;
  final String english;
  final String note;

  const VocabWord({
    required this.dari,
    required this.phonetic,
    required this.english,
    this.note = '',
  });
}

class MatchingPair {
  final String dari;
  final String english;

  const MatchingPair({
    required this.dari,
    required this.english,
  });
}