import 'lesson.dart';

class Unit {
  final int id;
  final String name;
  final String dari;
  final String iconText;
  final String description;
  final bool locked;
  final List<Lesson> lessons;

  const Unit({
    required this.id,
    required this.name,
    required this.dari,
    required this.iconText,
    required this.description,
    required this.lessons,
    this.locked = false,
  });

  Unit copyWith({
    int? id,
    String? name,
    String? dari,
    String? iconText,
    String? description,
    bool? locked,
    List<Lesson>? lessons,
  }) {
    return Unit(
      id: id ?? this.id,
      name: name ?? this.name,
      dari: dari ?? this.dari,
      iconText: iconText ?? this.iconText,
      description: description ?? this.description,
      locked: locked ?? this.locked,
      lessons: lessons ?? this.lessons,
    );
  }
}