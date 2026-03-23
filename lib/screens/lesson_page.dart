import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/unit.dart';
import '../state/app_state.dart';

class LessonPage extends StatelessWidget {
  final Unit unit;
  final int lessonIndex;

  const LessonPage({super.key, required this.unit, required this.lessonIndex});

  @override
  Widget build(BuildContext context) {
    final lesson = unit.lessons[lessonIndex];
    final appState = context.read<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(lesson.subtitle, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Type: ${lesson.type}'),
            Text('XP: ${lesson.xp}'),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: lesson.exercises
                    .map((e) => ListTile(
                          title: Text(e.prompt ?? 'Exercise'),
                          subtitle: Text(e.type.toString()),
                        ))
                    .toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                appState.completeLesson(unit.id, lessonIndex, lesson.xp);
                Navigator.pop(context);
              },
              child: const Text('Mark as complete'),
            ),
          ],
        ),
      ),
    );
  }
}
