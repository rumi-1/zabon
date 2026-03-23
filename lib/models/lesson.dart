import 'exercise.dart';

class Lesson {
  final String name;
  final String subtitle;
  final String type;
  final int xp;
  final List<Exercise> exercises;

  const Lesson({
    required this.name,
    required this.subtitle,
    required this.type,
    required this.xp,
    required this.exercises,
  });
}