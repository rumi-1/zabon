import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int xp = 0;
  int streak = 0;
  int wordsLearned = 0;

  // Profile information
  String profileName = 'Learner';
  String? profilePicturePath;
  DateTime? startDate;
  int currentUnitId = 0;

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

  // Profile methods
  void updateProfileName(String name) {
    profileName = name;
    notifyListeners();
  }

  void updateProfilePicture(String? path) {
    profilePicturePath = path;
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    notifyListeners();
  }

  void setCurrentUnit(int unitId) {
    currentUnitId = unitId;
    notifyListeners();
  }

  // Initialize default values
  void initializeDefaults() {
    startDate ??= DateTime.now();
  }
}