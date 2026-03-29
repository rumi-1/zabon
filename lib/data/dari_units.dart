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
      Lesson(
        name: 'Common Introductions',
        subtitle: 'معرفی‌های رایج',
        type: 'Vocabulary',
        xp: 15,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(
                dari: 'من',
                phonetic: 'man',
                english: 'I/me',
                note: 'First person pronoun',
              ),
              VocabWord(
                dari: 'شما',
                phonetic: 'shomâ',
                english: 'you (formal)',
                note: 'Formal you, used for respect',
              ),
              VocabWord(
                dari: 'اسم',
                phonetic: 'esm',
                english: 'name',
                note: 'What someone is called',
              ),
              VocabWord(
                dari: 'من هستم',
                phonetic: 'man hastam',
                english: 'I am',
                note: 'Present tense "to be"',
              ),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqEnglishToDari,
            prompt: 'How do you say "I am" in Dari?',
            english: 'I am',
            correct: 'من هستم',
            options: ['شما هستید', 'من هستم', 'او است', 'ما هستیم'],
          ),
          Exercise(
            type: ExerciseType.fillBlank,
            prompt: 'Fill in the blank: ___ علی هستم',
            sentenceParts: ['___', ' علی هستم'],
            blankAnswer: 'من',
            altAnswers: ['منم'],
          ),
        ],
      ),
      Lesson(
        name: 'Polite Expressions',
        subtitle: 'عبارات مودبانه',
        type: 'Vocabulary',
        xp: 12,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(
                dari: 'متشکرم',
                phonetic: 'motashakkeram',
                english: 'Thank you',
                note: 'Express gratitude',
              ),
              VocabWord(
                dari: 'خواهش می‌کنم',
                phonetic: 'khâhesh mikonam',
                english: 'You\'re welcome',
                note: 'Response to thanks',
              ),
              VocabWord(
                dari: 'ببخشید',
                phonetic: 'bebakhshid',
                english: 'Excuse me / Sorry',
                note: 'For apologies or getting attention',
              ),
              VocabWord(
                dari: 'لطفاً',
                phonetic: 'lotfan',
                english: 'Please',
                note: 'Make requests polite',
              ),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqDariToEnglish,
            prompt: 'What does "متشکرم" mean?',
            dari: 'متشکرم',
            phonetic: 'motashakkeram',
            correct: 'Thank you',
            options: ['You\'re welcome', 'Thank you', 'Please', 'Excuse me'],
          ),
          Exercise(
            type: ExerciseType.trueFalse,
            statementDari: 'خواهش می‌کنم',
            statementEnglish: 'You\'re welcome',
            answer: true,
          ),
          Exercise(
            type: ExerciseType.matching,
            prompt: 'Match the Dari phrases with their English meanings',
            pairs: [
              MatchingPair(dari: 'متشکرم', english: 'Thank you'),
              MatchingPair(dari: 'خواهش می‌کنم', english: 'You\'re welcome'),
              MatchingPair(dari: 'ببخشید', english: 'Excuse me'),
              MatchingPair(dari: 'لطفاً', english: 'Please'),
            ],
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 1,
    name: 'Family & Relationships',
    dari: 'خانواده و روابط',
    iconText: '👨‍👩‍👧‍👦',
    description: 'Learn words for family members and relationships.',
    lessons: [
      Lesson(
        name: 'Immediate Family',
        subtitle: 'خانواده نزدیک',
        type: 'Vocabulary',
        xp: 15,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'مادر', phonetic: 'mâdar', english: 'mother', note: 'Female parent'),
              VocabWord(dari: 'پدر', phonetic: 'pedar', english: 'father', note: 'Male parent'),
              VocabWord(dari: 'برادر', phonetic: 'barâdar', english: 'brother', note: 'Male sibling'),
              VocabWord(dari: 'خواهر', phonetic: 'khâhar', english: 'sister', note: 'Female sibling'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqDariToEnglish,
            prompt: 'What does "مادر" mean?',
            dari: 'مادر',
            phonetic: 'mâdar',
            correct: 'mother',
            options: ['father', 'mother', 'brother', 'sister'],
          ),
          Exercise(
            type: ExerciseType.fillBlank,
            prompt: 'Fill in the blank: ___ من مادر است',
            sentenceParts: ['___', ' من مادر است'],
            blankAnswer: 'او',
            altAnswers: ['اون'],
          ),
        ],
      ),
      Lesson(
        name: 'Extended Family',
        subtitle: 'خانواده گسترده',
        type: 'Vocabulary',
        xp: 18,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'پدربزرگ', phonetic: 'pedarbozorg', english: 'grandfather', note: 'Father\'s father'),
              VocabWord(dari: 'مادربزرگ', phonetic: 'mâdarbozorg', english: 'grandmother', note: 'Father\'s mother'),
              VocabWord(dari: 'عمو', phonetic: 'amo', english: 'uncle', note: 'Father\'s brother'),
              VocabWord(dari: 'خاله', phonetic: 'khâle', english: 'aunt', note: 'Mother\'s sister'),
              VocabWord(dari: 'پسرعمو', phonetic: 'pesaremo', english: 'cousin (male)', note: 'Uncle\'s son'),
            ],
          ),
          Exercise(
            type: ExerciseType.matching,
            prompt: 'Match the family members',
            pairs: [
              MatchingPair(dari: 'پدربزرگ', english: 'grandfather'),
              MatchingPair(dari: 'مادربزرگ', english: 'grandmother'),
              MatchingPair(dari: 'عمو', english: 'uncle'),
              MatchingPair(dari: 'خاله', english: 'aunt'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqEnglishToDari,
            prompt: 'How do you say "aunt" in Dari?',
            english: 'aunt',
            correct: 'خاله',
            options: ['عمو', 'خاله', 'پدربزرگ', 'مادربزرگ'],
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 2,
    name: 'Numbers & Time',
    dari: 'اعداد و زمان',
    iconText: '🔢',
    description: 'Learn numbers, days, months, and telling time.',
    lessons: [
      Lesson(
        name: 'Numbers 1-10',
        subtitle: 'اعداد ۱ تا ۱۰',
        type: 'Vocabulary',
        xp: 20,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'یک', phonetic: 'yek', english: 'one'),
              VocabWord(dari: 'دو', phonetic: 'do', english: 'two'),
              VocabWord(dari: 'سه', phonetic: 'se', english: 'three'),
              VocabWord(dari: 'چهار', phonetic: 'chahâr', english: 'four'),
              VocabWord(dari: 'پنج', phonetic: 'panj', english: 'five'),
              VocabWord(dari: 'شش', phonetic: 'shesh', english: 'six'),
              VocabWord(dari: 'هفت', phonetic: 'haft', english: 'seven'),
              VocabWord(dari: 'هشت', phonetic: 'hasht', english: 'eight'),
              VocabWord(dari: 'نه', phonetic: 'noh', english: 'nine'),
              VocabWord(dari: 'ده', phonetic: 'dah', english: 'ten'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqDariToEnglish,
            prompt: 'What number is "سه"?',
            dari: 'سه',
            phonetic: 'se',
            correct: 'three',
            options: ['two', 'three', 'four', 'five'],
          ),
          Exercise(
            type: ExerciseType.fillBlank,
            prompt: 'Fill in the blank: ___ کتاب دارم',
            sentenceParts: ['___', ' کتاب دارم'],
            blankAnswer: 'دو',
            altAnswers: ['۲'],
          ),
        ],
      ),
      Lesson(
        name: 'Days of the Week',
        subtitle: 'روزهای هفته',
        type: 'Vocabulary',
        xp: 16,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'شنبه', phonetic: 'shanbe', english: 'Saturday'),
              VocabWord(dari: 'یکشنبه', phonetic: 'yekshanbe', english: 'Sunday'),
              VocabWord(dari: 'دوشنبه', phonetic: 'doshanbe', english: 'Monday'),
              VocabWord(dari: 'سه‌شنبه', phonetic: 'seshanbe', english: 'Tuesday'),
              VocabWord(dari: 'چهارشنبه', phonetic: 'chahârshanbe', english: 'Wednesday'),
              VocabWord(dari: 'پنج‌شنبه', phonetic: 'panjshanbe', english: 'Thursday'),
              VocabWord(dari: 'جمعه', phonetic: 'jome', english: 'Friday'),
            ],
          ),
          Exercise(
            type: ExerciseType.matching,
            prompt: 'Match the days of the week',
            pairs: [
              MatchingPair(dari: 'شنبه', english: 'Saturday'),
              MatchingPair(dari: 'یکشنبه', english: 'Sunday'),
              MatchingPair(dari: 'دوشنبه', english: 'Monday'),
              MatchingPair(dari: 'سه‌شنبه', english: 'Tuesday'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqEnglishToDari,
            prompt: 'What is "Friday" in Dari?',
            english: 'Friday',
            correct: 'جمعه',
            options: ['شنبه', 'جمعه', 'یکشنبه', 'دوشنبه'],
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 3,
    name: 'Food & Dining',
    dari: 'غذا و خوردن',
    iconText: '🍽️',
    description: 'Learn food vocabulary and dining expressions.',
    lessons: [
      Lesson(
        name: 'Basic Foods',
        subtitle: 'غذاهای اساسی',
        type: 'Vocabulary',
        xp: 18,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'نان', phonetic: 'nân', english: 'bread', note: 'Staple food'),
              VocabWord(dari: 'برنج', phonetic: 'berenj', english: 'rice', note: 'Common grain'),
              VocabWord(dari: 'گوشت', phonetic: 'gosht', english: 'meat', note: 'Protein source'),
              VocabWord(dari: 'سبزی', phonetic: 'sabzi', english: 'vegetables', note: 'Plant foods'),
              VocabWord(dari: 'چای', phonetic: 'chây', english: 'tea', note: 'National drink'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqDariToEnglish,
            prompt: 'What does "چای" mean?',
            dari: 'چای',
            phonetic: 'chây',
            correct: 'tea',
            options: ['coffee', 'tea', 'water', 'juice'],
          ),
          Exercise(
            type: ExerciseType.fillBlank,
            prompt: 'Fill in the blank: من ___ دوست دارم',
            sentenceParts: ['من ___', ' دوست دارم'],
            blankAnswer: 'چای',
          ),
        ],
      ),
      Lesson(
        name: 'Dining Expressions',
        subtitle: 'عبارات غذایی',
        type: 'Vocabulary',
        xp: 14,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'خوردن', phonetic: 'khordan', english: 'to eat', note: 'Action of eating'),
              VocabWord(dari: 'نوشیدن', phonetic: 'noshidan', english: 'to drink', note: 'Action of drinking'),
              VocabWord(dari: 'گرسنه', phonetic: 'gersone', english: 'hungry', note: 'Feeling of hunger'),
              VocabWord(dari: 'تشنه', phonetic: 'teshne', english: 'thirsty', note: 'Feeling of thirst'),
              VocabWord(dari: 'خوشمزه', phonetic: 'khoshamze', english: 'delicious', note: 'Tastes good'),
            ],
          ),
          Exercise(
            type: ExerciseType.trueFalse,
            statementDari: 'گرسنه',
            statementEnglish: 'hungry',
            answer: true,
          ),
          Exercise(
            type: ExerciseType.matching,
            prompt: 'Match the dining expressions',
            pairs: [
              MatchingPair(dari: 'خوردن', english: 'to eat'),
              MatchingPair(dari: 'نوشیدن', english: 'to drink'),
              MatchingPair(dari: 'گرسنه', english: 'hungry'),
              MatchingPair(dari: 'خوشمزه', english: 'delicious'),
            ],
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 4,
    name: 'Colors & Descriptions',
    dari: 'رنگ‌ها و توصیفات',
    iconText: '🎨',
    description: 'Learn colors and descriptive adjectives.',
    lessons: [
      Lesson(
        name: 'Basic Colors',
        subtitle: 'رنگ‌های اساسی',
        type: 'Vocabulary',
        xp: 16,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'قرمز', phonetic: 'ghermez', english: 'red'),
              VocabWord(dari: 'آبی', phonetic: 'âbi', english: 'blue'),
              VocabWord(dari: 'سبز', phonetic: 'sabz', english: 'green'),
              VocabWord(dari: 'زرد', phonetic: 'zard', english: 'yellow'),
              VocabWord(dari: 'سیاه', phonetic: 'siyâh', english: 'black'),
              VocabWord(dari: 'سفید', phonetic: 'sefid', english: 'white'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqDariToEnglish,
            prompt: 'What color is "سبز"?',
            dari: 'سبز',
            phonetic: 'sabz',
            correct: 'green',
            options: ['blue', 'green', 'yellow', 'red'],
          ),
          Exercise(
            type: ExerciseType.fillBlank,
            prompt: 'Fill in the blank: آسمان ___ است',
            sentenceParts: ['آسمان ___', ' است'],
            blankAnswer: 'آبی',
          ),
        ],
      ),
      Lesson(
        name: 'Descriptive Words',
        subtitle: 'کلمات توصیفی',
        type: 'Vocabulary',
        xp: 15,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'بزرگ', phonetic: 'bozorg', english: 'big/large'),
              VocabWord(dari: 'کوچک', phonetic: 'kochak', english: 'small/little'),
              VocabWord(dari: 'خوب', phonetic: 'khob', english: 'good'),
              VocabWord(dari: 'بد', phonetic: 'bad', english: 'bad'),
              VocabWord(dari: 'زیبا', phonetic: 'zibâ', english: 'beautiful'),
              VocabWord(dari: 'زشت', phonetic: 'zesht', english: 'ugly'),
            ],
          ),
          Exercise(
            type: ExerciseType.matching,
            prompt: 'Match the opposites',
            pairs: [
              MatchingPair(dari: 'بزرگ', english: 'big'),
              MatchingPair(dari: 'کوچک', english: 'small'),
              MatchingPair(dari: 'خوب', english: 'good'),
              MatchingPair(dari: 'بد', english: 'bad'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqEnglishToDari,
            prompt: 'How do you say "beautiful" in Dari?',
            english: 'beautiful',
            correct: 'زیبا',
            options: ['زشت', 'زیبا', 'خوب', 'بد'],
          ),
        ],
      ),
    ],
  ),
  Unit(
    id: 5,
    name: 'Daily Activities',
    dari: 'فعالیت‌های روزانه',
    iconText: '🏠',
    description: 'Learn verbs and expressions for daily life.',
    lessons: [
      Lesson(
        name: 'Morning Routine',
        subtitle: 'روتین صبحگاهی',
        type: 'Vocabulary',
        xp: 17,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'بیدار شدن', phonetic: 'bidâr shodan', english: 'to wake up'),
              VocabWord(dari: 'شستن', phonetic: 'shostan', english: 'to wash'),
              VocabWord(dari: 'خوردن صبحانه', phonetic: 'khordan sobhâne', english: 'to eat breakfast'),
              VocabWord(dari: 'رفتن', phonetic: 'raftan', english: 'to go'),
              VocabWord(dari: 'کار کردن', phonetic: 'kâr kardan', english: 'to work'),
            ],
          ),
          Exercise(
            type: ExerciseType.mcqDariToEnglish,
            prompt: 'What does "بیدار شدن" mean?',
            dari: 'بیدار شدن',
            phonetic: 'bidâr shodan',
            correct: 'to wake up',
            options: ['to sleep', 'to wake up', 'to eat', 'to work'],
          ),
          Exercise(
            type: ExerciseType.fillBlank,
            prompt: 'Fill in the blank: من هر روز ___',
            sentenceParts: ['من هر روز ___', ''],
            blankAnswer: 'بیدار می‌شوم',
            altAnswers: ['بیدار می‌شم'],
          ),
        ],
      ),
      Lesson(
        name: 'Evening Activities',
        subtitle: 'فعالیت‌های عصر',
        type: 'Vocabulary',
        xp: 16,
        exercises: [
          Exercise(
            type: ExerciseType.vocabIntro,
            words: [
              VocabWord(dari: 'خوردن شام', phonetic: 'khordan shâm', english: 'to eat dinner'),
              VocabWord(dari: 'تماشا کردن', phonetic: 'tamâshâ kardan', english: 'to watch'),
              VocabWord(dari: 'خوابیدن', phonetic: 'khâbidan', english: 'to sleep'),
              VocabWord(dari: 'خواندن', phonetic: 'khândan', english: 'to read'),
              VocabWord(dari: 'صحبت کردن', phonetic: 'sohbat kardan', english: 'to talk'),
            ],
          ),
          Exercise(
            type: ExerciseType.trueFalse,
            statementDari: 'خوابیدن',
            statementEnglish: 'to sleep',
            answer: true,
          ),
          Exercise(
            type: ExerciseType.matching,
            prompt: 'Match the evening activities',
            pairs: [
              MatchingPair(dari: 'خوردن شام', english: 'to eat dinner'),
              MatchingPair(dari: 'تماشا کردن', english: 'to watch'),
              MatchingPair(dari: 'خوابیدن', english: 'to sleep'),
              MatchingPair(dari: 'خواندن', english: 'to read'),
            ],
          ),
        ],
      ),
    ],
  ),
];