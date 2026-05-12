import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/study_curriculum.dart';
import '../models/study_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'exercise_session_screen.dart';

class PracticePage extends StatefulWidget {
  const PracticePage({super.key});

  @override
  State<PracticePage> createState() => _PracticePageState();
}

class _PracticePageState extends State<PracticePage> {
  StudyLanguage _language = StudyLanguage.dari;

  void _startPractice() {
    final pool = List<LessonExercise>.from(allExercisesShuffled(_language))
      ..shuffle(Random());
    final pick = pool.take(5).toList();
    if (pick.length < 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Not enough exercises in this track yet.'),
        ),
      );
      return;
    }
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 380),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: ExerciseSessionScreen(
              language: _language,
              title: 'Quick practice',
              introPages: const [
                'Five random challenges from your track. Hearts still apply.',
              ],
              exercises: pick,
              lessonId: null,
              xpReward: 8,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<AppState>();
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            'Practice lab',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: AppTheme.zabonNavy,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            'Mixed drills: listening, meaning, translation, and word order. '
            'Smaller XP bonus — still counts toward your streak.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
          ),
          const SizedBox(height: 24),
          Align(
            alignment: Alignment.centerLeft,
            child: SegmentedButton<StudyLanguage>(
              segments: const [
                ButtonSegment(
                  value: StudyLanguage.dari,
                  label: Text('Dari'),
                  icon: Text('🏛️'),
                ),
                ButtonSegment(
                  value: StudyLanguage.pashto,
                  label: Text('Pashto'),
                  icon: Text('🏔️'),
                ),
              ],
              selected: {_language},
              onSelectionChanged: (s) {
                setState(() => _language = s.first);
              },
            ),
          ),
          const SizedBox(height: 28),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            builder: (context, t, child) {
              return Transform.scale(
                scale: 0.96 + 0.04 * t,
                child: Opacity(opacity: t, child: child),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.bolt_rounded,
                            color: AppTheme.leafDark, size: 32),
                        const SizedBox(width: 12),
                        Text(
                          'Lightning round',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.zabonNavy,
                              ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '• Listening clips\n'
                      '• Meaning matching\n'
                      '• Translation taps\n'
                      '• Word order puzzles',
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: _startPractice,
                        icon: const Icon(Icons.play_arrow_rounded),
                        label: const Text('START 5 CHALLENGES'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
