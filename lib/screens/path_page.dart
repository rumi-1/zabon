import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/study_curriculum.dart';
import '../models/study_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import 'exercise_session_screen.dart';
import 'lesson_pager_screen.dart';

/// Duolingo-style path merged with Roshan typography accents.
class PathPage extends StatefulWidget {
  const PathPage({super.key});

  @override
  State<PathPage> createState() => _PathPageState();
}

class _PathPageState extends State<PathPage> {
  StudyLanguage _language = StudyLanguage.dari;

  void _openLesson(PathLesson lesson) {
    Navigator.of(context).push(
      PageRouteBuilder<void>(
        transitionDuration: const Duration(milliseconds: 380),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.04),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: ExerciseSessionScreen(
                language: _language,
                title: lesson.title,
                introPages: lesson.introPages,
                exercises: lesson.exercises,
                lessonId: lesson.id,
                xpReward: lesson.xpReward,
              ),
            ),
          );
        },
      ),
    );
  }

  void _openReadingReference() {
    final pages = _language == StudyLanguage.dari
        ? _referenceDariPages
        : _referencePashtoPages;
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => LessonPagerScreen(
          title: _language == StudyLanguage.dari
              ? 'Dari · cultural notes'
              : 'Pashto · cultural notes',
          pages: pages,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppState>();
    final units = curriculumFor(_language);
    final orderedIds = allLessonIdsInOrder(_language);

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Learn',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.zabonNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _language == StudyLanguage.dari
                        ? 'دری • Dari'
                        : 'پښتو • Pashto',
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppTheme.zabonGold,
                    ),
                    textDirection: _language == StudyLanguage.dari
                        ? TextDirection.rtl
                        : TextDirection.rtl,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Streak ${app.streak} · ${app.pathLessonsClearedCount()} path lessons cleared',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      _LanguageChip(
                        label: _language == StudyLanguage.dari
                            ? 'Dari 🏛️'
                            : 'Pashto 🏔️',
                        onPressed: () async {
                          final next = await showModalBottomSheet<StudyLanguage>(
                            context: context,
                            showDragHandle: true,
                            builder: (ctx) => Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Choose track',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          fontWeight: FontWeight.w800,
                                          color: AppTheme.zabonNavy,
                                        ),
                                  ),
                                  const SizedBox(height: 16),
                                  ListTile(
                                    leading: const Text('🏛️',
                                        style: TextStyle(fontSize: 28)),
                                    title: const Text('Dari'),
                                    onTap: () => Navigator.pop(
                                        ctx, StudyLanguage.dari),
                                  ),
                                  ListTile(
                                    leading: const Text('🏔️',
                                        style: TextStyle(fontSize: 28)),
                                    title: const Text('Pashto'),
                                    onTap: () => Navigator.pop(
                                        ctx, StudyLanguage.pashto),
                                  ),
                                ],
                              ),
                            ),
                          );
                          if (next != null) {
                            setState(() => _language = next);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                tween: Tween(begin: 0, end: 1),
                builder: (context, t, child) {
                  return Opacity(
                    opacity: t,
                    child: Transform.translate(
                      offset: Offset(0, 12 * (1 - t)),
                      child: child,
                    ),
                  );
                },
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        leading:
                            Icon(Icons.menu_book_rounded, color: AppTheme.sky),
                        title: const Text('Reading reference'),
                        subtitle: const Text(
                            'Cultural notes — swipe pages, no exercises'),
                        trailing:
                            const Icon(Icons.chevron_right_rounded),
                        onTap: _openReadingReference,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ...units.expand((unit) {
            return [
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    unit.title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.zabonNavy,
                        ),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 12)),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, i) {
                      final lesson = unit.lessons[i];
                      final idx = orderedIds.indexOf(lesson.id);
                      final unlocked =
                          app.isPathLessonUnlocked(orderedIds, idx);
                      final done = app.isPathLessonDone(lesson.id);
                      final isLast = i == unit.lessons.length - 1;
                      return _LessonPathTile(
                        lesson: lesson,
                        unlocked: unlocked,
                        completed: done,
                        showConnectorBelow: !isLast,
                        onTap: unlocked
                            ? () => _openLesson(lesson)
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Finish the previous lesson to unlock this one.',
                                    ),
                                  ),
                                );
                              },
                      );
                    },
                    childCount: unit.lessons.length,
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 28)),
            ];
          }),
        ],
      ),
    );
  }
}

class _LanguageChip extends StatelessWidget {
  const _LanguageChip({
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.leaf.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                  color: AppTheme.zabonNavy,
                ),
              ),
              const SizedBox(width: 4),
              Icon(Icons.expand_more_rounded, color: Colors.grey.shade700),
            ],
          ),
        ),
      ),
    );
  }
}

class _LessonPathTile extends StatefulWidget {
  const _LessonPathTile({
    required this.lesson,
    required this.unlocked,
    required this.completed,
    required this.showConnectorBelow,
    required this.onTap,
  });

  final PathLesson lesson;
  final bool unlocked;
  final bool completed;
  final bool showConnectorBelow;
  final VoidCallback onTap;

  @override
  State<_LessonPathTile> createState() => _LessonPathTileState();
}

class _LessonPathTileState extends State<_LessonPathTile> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 52,
                child: Column(
                  children: [
                    AnimatedScale(
                      scale: _scale,
                      duration: const Duration(milliseconds: 120),
                      child: Material(
                        color: widget.completed
                            ? Colors.amber.shade400
                            : widget.unlocked
                                ? AppTheme.leaf
                                : Colors.grey.shade400,
                        shape: const CircleBorder(),
                        elevation: widget.unlocked ? 4 : 0,
                        shadowColor: AppTheme.leaf.withValues(alpha: 0.5),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: widget.onTap,
                          onHighlightChanged: (pressed) {
                            setState(() => _scale = pressed ? 0.92 : 1);
                          },
                          child: SizedBox(
                            width: 52,
                            height: 52,
                            child: Icon(
                              widget.completed
                                  ? Icons.star_rounded
                                  : widget.unlocked
                                      ? Icons.play_arrow_rounded
                                      : Icons.lock_rounded,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (widget.showConnectorBelow)
                      Container(
                        width: 4,
                        height: 28,
                        margin: const EdgeInsets.only(top: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: widget.unlocked
                                ? [
                                    AppTheme.leaf.withValues(alpha: 0.5),
                                    AppTheme.sky.withValues(alpha: 0.35),
                                  ]
                                : [
                                    Colors.grey.shade300,
                                    Colors.grey.shade200,
                                  ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  tween: Tween(begin: 0, end: 1),
                  builder: (context, t, child) {
                    return Opacity(
                      opacity: t,
                      child: Transform.translate(
                        offset: Offset(16 * (1 - t), 0),
                        child: child,
                      ),
                    );
                  },
                  child: Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: widget.onTap,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    widget.lesson.title,
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.zabonNavy,
                                    ),
                                  ),
                                ),
                                if (widget.completed)
                                  Icon(
                                    Icons.check_circle_rounded,
                                    color: Colors.green.shade600,
                                  ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              widget.lesson.description,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.grey.shade700,
                                height: 1.35,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '+${widget.lesson.xpReward} XP · ${widget.lesson.exercises.length} exercises',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: AppTheme.leafDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

const List<String> _referenceDariPages = [
  '''
Dari (دری) is a branch of the Persian language spoken mainly in Afghanistan.
It is one of the country’s official languages and remains central to education,
literature, media, and government life.

Read at your own pace, then return to the path for interactive exercises.
''',
  '''
Dari shares deep roots with Iranian Persian (Farsi) and Tajiki, yet it has its
own sound system, preferred vocabulary, and rhythms of speech.

The language is spoken alongside Pashto throughout Afghanistan.
''',
  '''
تکرار مادرِ دانش است — takrār mādar-e dānish ast — “Repetition is the mother of learning.”
''',
];

const List<String> _referencePashtoPages = [
  '''
Pashto (پښتو) is spoken across Afghanistan and Pashtun regions — poetry and
story traditions remain central to daily life.

Use this reader for context; drills live on the learning path.
''',
  '''
Pashto has rich dialect diversity; shared culture keeps learners connected
alongside Dari throughout Afghanistan.
''',
];
