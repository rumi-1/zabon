import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/unit.dart';
import '../models/exercise.dart';
import '../state/app_state.dart';

class LessonPage extends StatefulWidget {
  final Unit unit;
  final int lessonIndex;

  const LessonPage({super.key, required this.unit, required this.lessonIndex});

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  int currentExerciseIndex = 0;
  Map<int, String?> userAnswers = {};
  Map<int, bool> exerciseCompleted = {};

  @override
  Widget build(BuildContext context) {
    final lesson = widget.unit.lessons[widget.lessonIndex];
    final appState = context.read<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.name),
        actions: [
          if (currentExerciseIndex > 0)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => currentExerciseIndex--),
            ),
          if (currentExerciseIndex < lesson.exercises.length - 1)
            IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => setState(() => currentExerciseIndex++),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress indicator
            LinearProgressIndicator(
              value: (currentExerciseIndex + 1) / lesson.exercises.length,
            ),
            const SizedBox(height: 8),
            Text(
              'Exercise ${currentExerciseIndex + 1} of ${lesson.exercises.length}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 16),

            // Exercise content
            Expanded(
              child: _buildExercise(lesson.exercises[currentExerciseIndex]),
            ),

            // Navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentExerciseIndex > 0)
                  ElevatedButton(
                    onPressed: () => setState(() => currentExerciseIndex--),
                    child: const Text('Previous'),
                  )
                else
                  const SizedBox.shrink(),
                if (currentExerciseIndex < lesson.exercises.length - 1)
                  ElevatedButton(
                    onPressed: () => setState(() => currentExerciseIndex++),
                    child: const Text('Next'),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      appState.completeLesson(widget.unit.id, widget.lessonIndex, lesson.xp);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text('Complete Lesson'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercise(Exercise exercise) {
    switch (exercise.type) {
      case ExerciseType.vocabIntro:
        return _buildVocabIntro(exercise);
      case ExerciseType.mcqDariToEnglish:
        return _buildMCQDariToEnglish(exercise);
      case ExerciseType.mcqEnglishToDari:
        return _buildMCQEnglishToDari(exercise);
      case ExerciseType.fillBlank:
        return _buildFillBlank(exercise);
      case ExerciseType.matching:
        return _buildMatching(exercise);
      case ExerciseType.trueFalse:
        return _buildTrueFalse(exercise);
      case ExerciseType.wordBank:
        return _buildWordBank(exercise);
    }
  }

  Widget _buildVocabIntro(Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Learn these words:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: exercise.words?.length ?? 0,
            itemBuilder: (context, index) {
              final word = exercise.words![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word.dari,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8B4513),
                        ),
                      ),
                      Text(
                        word.phonetic,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        word.english,
                        style: const TextStyle(fontSize: 18),
                      ),
                      if (word.note.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          word.note,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMCQDariToEnglish(Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.prompt ?? 'What does this mean?',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          exercise.dari ?? '',
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B4513),
          ),
        ),
        if (exercise.phonetic != null) ...[
          Text(
            exercise.phonetic!,
            style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
        ],
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: (exercise.options ?? []).map((option) {
              final isSelected = userAnswers[currentExerciseIndex] == option;
              final isCorrect = option == exercise.correct;
              final showResult = exerciseCompleted[currentExerciseIndex] == true;

              return Card(
                color: showResult
                    ? (isCorrect ? Colors.green.shade100 : (isSelected ? Colors.red.shade100 : null))
                    : (isSelected ? Colors.blue.shade100 : null),
                child: ListTile(
                  title: Text(option),
                  trailing: showResult && isCorrect ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: exerciseCompleted[currentExerciseIndex] == true
                      ? null
                      : () {
                          setState(() {
                            userAnswers[currentExerciseIndex] = option;
                            exerciseCompleted[currentExerciseIndex] = true;
                          });
                        },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildMCQEnglishToDari(Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.prompt ?? 'How do you say this in Dari?',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          exercise.english ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView(
            children: (exercise.options ?? []).map((option) {
              final isSelected = userAnswers[currentExerciseIndex] == option;
              final isCorrect = option == exercise.correct;
              final showResult = exerciseCompleted[currentExerciseIndex] == true;

              return Card(
                color: showResult
                    ? (isCorrect ? Colors.green.shade100 : (isSelected ? Colors.red.shade100 : null))
                    : (isSelected ? Colors.blue.shade100 : null),
                child: ListTile(
                  title: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8B4513),
                    ),
                  ),
                  trailing: showResult && isCorrect ? const Icon(Icons.check, color: Colors.green) : null,
                  onTap: exerciseCompleted[currentExerciseIndex] == true
                      ? null
                      : () {
                          setState(() {
                            userAnswers[currentExerciseIndex] = option;
                            exerciseCompleted[currentExerciseIndex] = true;
                          });
                        },
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildFillBlank(Exercise exercise) {
    final controller = TextEditingController(text: userAnswers[currentExerciseIndex] ?? '');
    final isCompleted = exerciseCompleted[currentExerciseIndex] == true;
    final isCorrect = userAnswers[currentExerciseIndex]?.toLowerCase() == exercise.blankAnswer?.toLowerCase();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.prompt ?? 'Fill in the blank',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              exercise.sentenceParts?[0] ?? '',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                enabled: !isCompleted,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Type here',
                  filled: isCompleted,
                  fillColor: isCompleted
                      ? (isCorrect ? Colors.green.shade100 : Colors.red.shade100)
                      : null,
                ),
                onChanged: (value) {
                  userAnswers[currentExerciseIndex] = value;
                },
                onSubmitted: (_) {
                  setState(() {
                    exerciseCompleted[currentExerciseIndex] = true;
                  });
                },
              ),
            ),
            const SizedBox(width: 8),
            Text(
              exercise.sentenceParts?[1] ?? '',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        if (isCompleted) ...[
          const SizedBox(height: 16),
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Text(
                isCorrect ? 'Correct!' : 'The correct answer is: ${exercise.blankAnswer}',
                style: TextStyle(
                  color: isCorrect ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildMatching(Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.prompt ?? 'Match the words',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: exercise.pairs?.length ?? 0,
            itemBuilder: (context, index) {
              final pair = exercise.pairs![index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          pair.dari,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF8B4513),
                          ),
                        ),
                      ),
                      const Icon(Icons.arrow_forward),
                      Expanded(
                        child: Text(
                          pair.english,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrueFalse(Exercise exercise) {
    final userAnswer = userAnswers[currentExerciseIndex];
    final isCompleted = exerciseCompleted[currentExerciseIndex] == true;
    final isCorrect = userAnswer == (exercise.answer == true ? 'true' : 'false');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'True or False?',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          exercise.statementDari ?? '',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8B4513),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          exercise.statementEnglish ?? '',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: isCompleted
                    ? null
                    : () {
                        setState(() {
                          userAnswers[currentExerciseIndex] = 'true';
                          exerciseCompleted[currentExerciseIndex] = true;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: userAnswer == 'true'
                      ? (isCompleted
                          ? (isCorrect ? Colors.green : Colors.red)
                          : Colors.blue)
                      : null,
                ),
                child: const Text('True'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: isCompleted
                    ? null
                    : () {
                        setState(() {
                          userAnswers[currentExerciseIndex] = 'false';
                          exerciseCompleted[currentExerciseIndex] = true;
                        });
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: userAnswer == 'false'
                      ? (isCompleted
                          ? (isCorrect ? Colors.green : Colors.red)
                          : Colors.blue)
                      : null,
                ),
                child: const Text('False'),
              ),
            ),
          ],
        ),
        if (isCompleted) ...[
          const SizedBox(height: 16),
          Text(
            isCorrect ? 'Correct!' : 'Incorrect. The statement is ${exercise.answer == true ? 'true' : 'false'}.',
            style: TextStyle(
              color: isCorrect ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildWordBank(Exercise exercise) {
    final userAnswer = userAnswers[currentExerciseIndex] ?? '';
    final isCompleted = exerciseCompleted[currentExerciseIndex] == true;
    final isCorrect = userAnswer.trim() == exercise.targetSentence;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          exercise.prompt ?? 'Build the sentence using the word bank',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),

        // Target sentence hint (English)
        if (exercise.english != null) ...[
          Text(
            exercise.english!,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
        ],

        // Answer area
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCompleted
                ? (isCorrect ? Colors.green.shade50 : Colors.red.shade50)
                : Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isCompleted
                  ? (isCorrect ? Colors.green : Colors.red)
                  : Colors.grey,
            ),
          ),
          child: Text(
            userAnswer.isEmpty ? 'Tap words below to build your sentence...' : userAnswer,
            style: TextStyle(
              fontSize: 16,
              color: userAnswer.isEmpty ? Colors.grey : Colors.black,
            ),
          ),
        ),

        if (isCompleted) ...[
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isCorrect
                      ? 'Correct!'
                      : 'The correct sentence is: ${exercise.targetSentence}',
                  style: TextStyle(
                    color: isCorrect ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],

        const SizedBox(height: 24),

        // Word bank
        Text(
          'Word Bank:',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 12),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: (exercise.wordBank ?? []).map((word) {
            final isUsed = userAnswer.contains(word);
            return ElevatedButton(
              onPressed: isCompleted
                  ? null
                  : () {
                      final currentAnswer = userAnswers[currentExerciseIndex] ?? '';
                      final newAnswer = currentAnswer.isEmpty ? word : '$currentAnswer $word';
                      setState(() {
                        userAnswers[currentExerciseIndex] = newAnswer;
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: isUsed ? Colors.grey.shade300 : const Color(0xFFC9922A),
                foregroundColor: isUsed ? Colors.grey : Colors.white,
              ),
              child: Text(word),
            );
          }).toList(),
        ),

        const SizedBox(height: 16),

        // Clear and Submit buttons
        if (!isCompleted)
          Row(
            children: [
              TextButton(
                onPressed: () {
                  setState(() {
                    userAnswers[currentExerciseIndex] = '';
                  });
                },
                child: const Text('Clear'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    exerciseCompleted[currentExerciseIndex] = true;
                  });
                },
                child: const Text('Submit'),
              ),
            ],
          ),
      ],
    );
  }
}
