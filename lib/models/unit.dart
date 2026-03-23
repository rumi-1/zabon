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
}