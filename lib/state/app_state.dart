import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int xp = 0;
  int streak = 0;
  int wordsLearned = 0;

  final Map<int, Set<int>> completedLessons = {};
  final Set<String> masteredLetters = {};

  bool isLessonComplete(int unitId, int lessonIndex) {
    return completedLessons[unitId]?.contains(lessonIndex) ?? false;
  }

  void completeLesson(int unitId, int lessonIndex, int lessonXp) {
    completedLessons.putIfAbsent(unitId, () => <int>{});
    if (!completedLessons[unitId]!.contains(lessonIndex)) {
      completedLessons[unitId]!.add(lessonIndex);
      xp += lessonXp;
      notifyListeners();
    }
  }

  int completedCountForUnit(int unitId) {
    return completedLessons[unitId]?.length ?? 0;
  }

  void toggleMasteredLetter(String letter) {
    if (masteredLetters.contains(letter)) {
      masteredLetters.remove(letter);
    } else {
      masteredLetters.add(letter);
      xp += 2;
    }
    notifyListeners();
  }
}