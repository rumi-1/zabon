import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/unit.dart';
import '../state/app_state.dart';
import 'lesson_page.dart';

class UnitPage extends StatelessWidget {
  final Unit unit;

  const UnitPage({super.key, required this.unit});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(unit.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            unit.dari,
            style: const TextStyle(
              fontSize: 22,
              color: Color(0xFFC9922A),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            unit.description,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF4A3E28),
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(unit.lessons.length, (index) {
            final lesson = unit.lessons[index];
            final isDone = appState.isLessonComplete(unit.id, index);
            final isUnlocked = index == 0 || appState.isLessonComplete(unit.id, index - 1);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0x221A3A5C)),
                ),
                tileColor: isDone
                    ? const Color(0xFFEAF3EE)
                    : isUnlocked
                        ? Colors.white
                        : const Color(0xFFF5EDD8),
                leading: CircleAvatar(
                  child: Text(isDone ? '✓' : '${index + 1}'),
                ),
                title: Text(lesson.name),
                subtitle: Text(lesson.subtitle),
                trailing: Text(lesson.type),
                onTap: isUnlocked
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LessonPage(
                              unit: unit,
                              lessonIndex: index,
                            ),
                          ),
                        );
                      }
                    : null,
              ),
            );
          }),
        ],
      ),
    );
  }
}