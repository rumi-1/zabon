import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  int xp = 0;
  int streak = 0;
  int wordsLearned = 0;

  String profileName = 'Learner';
  String? profilePicturePath;
  DateTime? startDate;
  int currentUnitId = 0;

  /// Legacy structured lessons from original units (`dari_units`).
  final Map<int, Set<int>> completedLessons = {};
  final Set<String> masteredLetters = {};

  /// Duolingo-style path lesson IDs (`study_curriculum`).
  final Set<String> pathCompletedLessonIds = <String>{};
  DateTime? lastPracticeDay;

  bool isLessonComplete(int unitId, int lessonIndex) {
    return completedLessons[unitId]?.contains(lessonIndex) ?? false;
  }

  void completeLesson(int unitId, int lessonIndex, int lessonXp) {
    completedLessons.putIfAbsent(unitId, () => <int>{});
    if (!completedLessons[unitId]!.contains(lessonIndex)) {
      completedLessons[unitId]!.add(lessonIndex);
      xp += lessonXp;
      _persist();
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
    _persist();
    notifyListeners();
  }

  void updateProfileName(String name) {
    profileName = name;
    _persist();
    notifyListeners();
  }

  void updateProfilePicture(String? path) {
    profilePicturePath = path;
    _persist();
    notifyListeners();
  }

  void setStartDate(DateTime date) {
    startDate = date;
    _persist();
    notifyListeners();
  }

  void setCurrentUnit(int unitId) {
    currentUnitId = unitId;
    _persist();
    notifyListeners();
  }

  bool isPathLessonDone(String lessonId) =>
      pathCompletedLessonIds.contains(lessonId);

  bool isPathLessonUnlocked(List<String> orderedLessonIds, int index) {
    if (index <= 0) return true;
    return pathCompletedLessonIds.contains(orderedLessonIds[index - 1]);
  }

  Future<void> completePathLesson(String lessonId, int xpReward) async {
    _applyStreak();
    if (!pathCompletedLessonIds.contains(lessonId)) {
      pathCompletedLessonIds.add(lessonId);
      xp += xpReward;
    }
    await _persist();
    notifyListeners();
  }

  Future<void> recordPracticeSession(int bonusXp) async {
    _applyStreak();
    xp += bonusXp;
    await _persist();
    notifyListeners();
  }

  void _applyStreak() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final last = lastPracticeDay;
    if (last == null) {
      streak = 1;
      lastPracticeDay = today;
      return;
    }
    final lastDay = DateTime(last.year, last.month, last.day);
    final diff = today.difference(lastDay).inDays;
    if (diff == 0) {
      return;
    }
    if (diff == 1) {
      streak += 1;
    } else {
      streak = 1;
    }
    lastPracticeDay = today;
  }

  Future<void> initializeDefaults() async {
    await load();
    startDate ??= DateTime.now();
    await _persist();
    notifyListeners();
  }

  Future<void> load() async {
    final p = await SharedPreferences.getInstance();
    xp = p.getInt('zab_xp') ?? 0;
    streak = p.getInt('zab_streak') ?? 0;
    wordsLearned = p.getInt('zab_words_learned') ?? 0;
    profileName = p.getString('zab_profile_name') ?? 'Learner';
    profilePicturePath = p.getString('zab_profile_pic');
    currentUnitId = p.getInt('zab_current_unit') ?? 0;
    final sd = p.getString('zab_start_date');
    if (sd != null) {
      startDate = DateTime.tryParse(sd);
    }
    final lpd = p.getString('zab_last_practice');
    if (lpd != null) {
      lastPracticeDay = DateTime.tryParse(lpd);
    }

    final pathRaw = p.getString('zab_path_completed');
    if (pathRaw != null && pathRaw.isNotEmpty) {
      pathCompletedLessonIds
        ..clear()
        ..addAll(Set<String>.from(jsonDecode(pathRaw) as List<dynamic>));
    }

    final masteredRaw = p.getString('zab_mastered_letters');
    if (masteredRaw != null && masteredRaw.isNotEmpty) {
      masteredLetters
        ..clear()
        ..addAll(Set<String>.from(jsonDecode(masteredRaw) as List<dynamic>));
    }

    final legacyRaw = p.getString('zab_legacy_completed');
    if (legacyRaw != null && legacyRaw.isNotEmpty) {
      final map = jsonDecode(legacyRaw) as Map<String, dynamic>;
      completedLessons.clear();
      for (final e in map.entries) {
        final uid = int.parse(e.key);
        final list = (e.value as List<dynamic>).cast<int>();
        completedLessons[uid] = list.toSet();
      }
    }
  }

  Future<void> _persist() async {
    final p = await SharedPreferences.getInstance();
    await p.setInt('zab_xp', xp);
    await p.setInt('zab_streak', streak);
    await p.setInt('zab_words_learned', wordsLearned);
    await p.setString('zab_profile_name', profileName);
    if (profilePicturePath != null) {
      await p.setString('zab_profile_pic', profilePicturePath!);
    } else {
      await p.remove('zab_profile_pic');
    }
    await p.setInt('zab_current_unit', currentUnitId);
    if (startDate != null) {
      await p.setString('zab_start_date', startDate!.toIso8601String());
    }
    if (lastPracticeDay != null) {
      await p.setString(
        'zab_last_practice',
        lastPracticeDay!.toIso8601String(),
      );
    }
    await p.setString(
      'zab_path_completed',
      jsonEncode(pathCompletedLessonIds.toList()),
    );
    await p.setString(
      'zab_mastered_letters',
      jsonEncode(masteredLetters.toList()),
    );
    final legacyMap = <String, dynamic>{};
    for (final e in completedLessons.entries) {
      legacyMap[e.key.toString()] = e.value.toList();
    }
    await p.setString('zab_legacy_completed', jsonEncode(legacyMap));
  }

  int pathLessonsClearedCount() => pathCompletedLessonIds.length;
}
