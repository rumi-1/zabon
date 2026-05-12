import 'dart:math';

import 'package:flutter/material.dart';

import '../../models/study_models.dart';
import '../../utils/romanization.dart';
import '../simple_audio_player.dart';

class ExercisePanel extends StatelessWidget {
  const ExercisePanel({
    super.key,
    required this.exercise,
    required this.language,
    required this.enabled,
    required this.selectedIndex,
    required this.showResult,
    required this.wasWrong,
    required this.onSelectChoice,
    required this.wordAvailable,
    required this.wordPicked,
    required this.onPickWord,
    required this.onUnpickWord,
    required this.wordOrderCorrect,
  });

  final LessonExercise exercise;
  final StudyLanguage language;
  final bool enabled;
  final int? selectedIndex;
  final bool showResult;
  final bool wasWrong;
  final ValueChanged<int> onSelectChoice;
  final List<String> wordAvailable;
  final List<String> wordPicked;
  final ValueChanged<String> onPickWord;
  final ValueChanged<String> onUnpickWord;
  final bool? wordOrderCorrect;

  @override
  Widget build(BuildContext context) {
    switch (exercise.kind) {
      case ExerciseKind.chooseTranslation:
      case ExerciseKind.chooseMeaning:
      case ExerciseKind.listening:
        return _ChoiceBlock(
          exercise: exercise,
          language: language,
          enabled: enabled,
          selectedIndex: selectedIndex,
          showResult: showResult,
          wasWrong: wasWrong,
          onSelectChoice: onSelectChoice,
        );
      case ExerciseKind.arrangeWords:
        return _WordOrderBlock(
          exercise: exercise,
          language: language,
          enabled: enabled,
          available: wordAvailable,
          picked: wordPicked,
          onPick: onPickWord,
          onUnpick: onUnpickWord,
          showResult: showResult,
          wasWrong: wasWrong,
          isCorrect: wordOrderCorrect,
        );
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _ChoiceBlock extends StatelessWidget {
  const _ChoiceBlock({
    required this.exercise,
    required this.language,
    required this.enabled,
    required this.selectedIndex,
    required this.showResult,
    required this.wasWrong,
    required this.onSelectChoice,
  });

  final LessonExercise exercise;
  final StudyLanguage language;
  final bool enabled;
  final int? selectedIndex;
  final bool showResult;
  final bool wasWrong;
  final ValueChanged<int> onSelectChoice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            exercise.prompt,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          if (exercise.kind == ExerciseKind.listening &&
              exercise.audioAsset != null) ...[
            const SizedBox(height: 16),
            Center(
              child: SimpleAudioPlayer(audioAssetPath: exercise.audioAsset!),
            ),
            const SizedBox(height: 20),
          ],
          if (exercise.promptHint != null &&
              exercise.kind == ExerciseKind.chooseMeaning) ...[
            const SizedBox(height: 16),
            _ScriptCard(
              script: exercise.promptHint!,
              language: language,
            ),
          ],
          if (exercise.kind != ExerciseKind.listening) const SizedBox(height: 20),
          ...List.generate(exercise.choices.length, (i) {
            final text = exercise.choices[i];
            final selected = selectedIndex == i;
            Color? border;
            Color? bg;
            if (showResult) {
              if (i == exercise.correctIndex) {
                border = Colors.green.shade600;
                bg = Colors.green.shade50;
              } else if (selected && i != exercise.correctIndex) {
                border = Colors.red.shade400;
                bg = Colors.red.shade50;
              }
            } else if (selected) {
              border = theme.colorScheme.primary;
              bg = theme.colorScheme.primary.withValues(alpha: 0.08);
            }

            final roman = getRomanization(text, language);

            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Material(
                color: bg ?? Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: enabled ? () => onSelectChoice(i) : null,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: border ?? Colors.grey.shade300,
                        width: border != null ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: hasScript(text)
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      text,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: theme.textTheme.titleMedium
                                          ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    if (roman != null)
                                      Text(
                                        roman,
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade500,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                  ],
                                )
                              : Text(
                                  text,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                        const SizedBox(width: 8),
                        if (showResult && i == exercise.correctIndex)
                          Icon(Icons.check_circle,
                              color: Colors.green.shade700, size: 22),
                        if (showResult &&
                            selected &&
                            i != exercise.correctIndex)
                          Icon(Icons.cancel_rounded,
                              color: Colors.red.shade400, size: 22),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
          if (wasWrong && showResult)
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                'Not quite — try another option.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _WordOrderBlock extends StatelessWidget {
  const _WordOrderBlock({
    required this.exercise,
    required this.language,
    required this.enabled,
    required this.available,
    required this.picked,
    required this.onPick,
    required this.onUnpick,
    required this.showResult,
    required this.wasWrong,
    required this.isCorrect,
  });

  final LessonExercise exercise;
  final StudyLanguage language;
  final bool enabled;
  final List<String> available;
  final List<String> picked;
  final ValueChanged<String> onPick;
  final ValueChanged<String> onUnpick;
  final bool showResult;
  final bool wasWrong;
  final bool? isCorrect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final lineColor = showResult
        ? (isCorrect == true
            ? Colors.green.shade600
            : isCorrect == false
                ? Colors.red.shade400
                : Colors.grey.shade300)
        : Colors.grey.shade300;

    // Dari and Pashto both use RTL script — word chips flow right-to-left
    const wrapDirection = TextDirection.rtl;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            exercise.prompt,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 16),

          // Picked words drop zone
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: lineColor, width: 2),
            ),
            constraints: const BoxConstraints(minHeight: 60),
            child: picked.isEmpty
                ? Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Text(
                      'اینجا بنویسید ↑',
                      textDirection: TextDirection.rtl,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade400,
                      ),
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    textDirection: wrapDirection,
                    children: picked
                        .map(
                          (w) => _Chip(
                            label: w,
                            language: language,
                            enabled: enabled,
                            onTap: () => onUnpick(w),
                            filled: true,
                          ),
                        )
                        .toList(),
                  ),
          ),

          const SizedBox(height: 20),
          Text(
            'Word bank · کلمات',
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            textDirection: wrapDirection,
            children: available
                .map(
                  (w) => _Chip(
                    label: w,
                    language: language,
                    enabled: enabled,
                    onTap: () => onPick(w),
                    filled: false,
                  ),
                )
                .toList(),
          ),

          if (wasWrong && showResult && isCorrect == false)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Word order needs a fix — reset and try again.',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

/// Prominent display card for a script phrase with romanization below.
class _ScriptCard extends StatelessWidget {
  const _ScriptCard({required this.script, required this.language});

  final String script;
  final StudyLanguage language;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final roman = getRomanization(script, language);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        children: [
          Text(
            script,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          if (roman != null) ...[
            const SizedBox(height: 4),
            Text(
              roman,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.language,
    required this.enabled,
    required this.onTap,
    required this.filled,
  });

  final String label;
  final StudyLanguage language;
  final bool enabled;
  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final roman = getRomanization(label, language);

    return Material(
      color: filled
          ? theme.colorScheme.primary.withValues(alpha: 0.15)
          : Colors.grey.shade100,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: enabled ? onTap : null,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: roman != null ? 8 : 10,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: filled
                      ? theme.colorScheme.primary
                      : Colors.grey.shade800,
                ),
              ),
              if (roman != null)
                Text(
                  roman,
                  style: TextStyle(
                    fontSize: 11,
                    color: filled
                        ? theme.colorScheme.primary.withValues(alpha: 0.7)
                        : Colors.grey.shade500,
                    fontStyle: FontStyle.italic,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

List<String> shuffledWords(List<String> words) {
  final copy = List<String>.from(words);
  copy.shuffle(Random());
  return copy;
}
