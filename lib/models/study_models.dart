/// Models for the Duolingo-style learning path (distinct from legacy `Lesson` in `lesson.dart`).
library;

enum StudyLanguage { dari, pashto }

enum ExerciseKind {
  chooseTranslation,
  chooseMeaning,
  listening,
  arrangeWords,
}

class LessonExercise {
  const LessonExercise({
    required this.id,
    required this.kind,
    required this.prompt,
    this.promptHint,
    this.targetPhrase,
    this.choices = const [],
    this.correctIndex = 0,
    this.audioAsset,
    this.wordBank,
    this.correctWordOrder,
  });

  final String id;
  final ExerciseKind kind;
  final String prompt;
  final String? promptHint;
  final String? targetPhrase;
  final List<String> choices;
  final int correctIndex;
  final String? audioAsset;
  final List<String>? wordBank;
  final List<String>? correctWordOrder;
}

class PathLesson {
  const PathLesson({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    this.introPages = const [],
    required this.exercises,
  });

  final String id;
  final String title;
  final String description;
  final int xpReward;
  final List<String> introPages;
  final List<LessonExercise> exercises;
}

class PathUnit {
  const PathUnit({
    required this.id,
    required this.title,
    required this.lessons,
  });

  final String id;
  final String title;
  final List<PathLesson> lessons;
}
