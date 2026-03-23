import '../models/unit.dart';
import '../models/lesson.dart';
import '../models/exercise.dart';

const List<Unit> dariUnits = [
  Unit(
    id: 0,
    name: 'Greetings & Introductions',
    dari: 'سلام و معرفی',
    iconText: 'سلام',
    description: 'Learn greetings, introductions, and basic pleasantries.',
    lessons: [
      Lesson(
        name: 'Basic Greetings',
        subtitle: 'سلام‌های اساسی',
        type: 'Vocabulary',
        xp: 10,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(
                dari: 'سلام',
                phonetic: 'salâm',
                english: 'Hello / Peace',
                note: 'Universal greeting',
              ),
              VocabWord(
                dari: 'خداحافظ',
                phonetic: 'khodâhâfez',
                english: 'Goodbye',
              ),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqDariToEnglish,
            prompt: 'What does this mean?',
            dari: 'سلام',
            phonetic: 'salâm',
            correct: 'Hello / Peace',
            options: ['Goodbye', 'Hello / Peace', 'Good morning', 'Thank you'],
          ),
        ],
      ),
    ],
  ),
];