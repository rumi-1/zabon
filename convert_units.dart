import 'dart:convert';

void main() {
  // Data from dari_units.dart
  final units = [
    {
      'id': 0,
      'name': 'Greetings & Introductions',
      'dari': 'سلام و معرفی',
      'lessons': [
        {
          'name': 'Basic Greetings',
          'subtitle': 'سلام‌های اساسی',
          'xp': 10,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'سلام', 'english': 'Hello / Peace'},
                {'dari': 'خداحافظ', 'english': 'Goodbye'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'سلام',
              'correct': 'Hello / Peace',
              'options': ['Goodbye', 'Hello / Peace', 'Good morning', 'Thank you'],
            },
          ],
        },
        {
          'name': 'Common Introductions',
          'subtitle': 'معرفی‌های رایج',
          'xp': 15,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'من', 'english': 'I/me'},
                {'dari': 'شما', 'english': 'you (formal)'},
                {'dari': 'اسم', 'english': 'name'},
                {'dari': 'من هستم', 'english': 'I am'},
              ],
            },
            {
              'type': 'mcqEnglishToDari',
              'english': 'I am',
              'correct': 'من هستم',
              'options': ['شما هستید', 'من هستم', 'او است', 'ما هستیم'],
            },
            {
              'type': 'dragDropSentence',
              'dragSentenceParts': ['من', '___', 'هستم'],
              'dragWords': ['از', 'اسم', 'من'],
              'correctOrder': ['اسم'],
            },
          ],
        },
        {
          'name': 'Polite Expressions',
          'subtitle': 'عبارات مودبانه',
          'xp': 12,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'متشکرم', 'english': 'Thank you'},
                {'dari': 'خواهش می‌کنم', 'english': 'You\'re welcome'},
                {'dari': 'ببخشید', 'english': 'Excuse me / Sorry'},
                {'dari': 'لطفاً', 'english': 'Please'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'متشکرم',
              'correct': 'Thank you',
              'options': ['You\'re welcome', 'Thank you', 'Please', 'Excuse me'],
            },
            {
              'type': 'trueFalse',
              'statementDari': 'خواهش می‌کنم',
              'statementEnglish': 'You\'re welcome',
              'answer': true,
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'متشکرم', 'english': 'Thank you'},
                {'dari': 'خواهش می‌کنم', 'english': 'You\'re welcome'},
                {'dari': 'ببخشید', 'english': 'Excuse me'},
                {'dari': 'لطفاً', 'english': 'Please'},
              ],
            },
          ],
        },
      ],
    },
    {
      'id': 1,
      'name': 'Family & Relationships',
      'dari': 'خانواده و روابط',
      'lessons': [
        {
          'name': 'Immediate Family',
          'subtitle': 'خانواده نزدیک',
          'xp': 15,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'مادر', 'english': 'mother'},
                {'dari': 'پدر', 'english': 'father'},
                {'dari': 'برادر', 'english': 'brother'},
                {'dari': 'خواهر', 'english': 'sister'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'مادر',
              'correct': 'mother',
              'options': ['father', 'mother', 'brother', 'sister'],
            },
            {
              'type': 'dragDropSentence',
              'dragSentenceParts': ['___', 'من مادر است'],
              'dragWords': ['او', 'من', 'شما'],
              'correctOrder': ['او'],
            },
          ],
        },
        {
          'name': 'Extended Family',
          'subtitle': 'خانواده گسترده',
          'xp': 18,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'پدربزرگ', 'english': 'grandfather'},
                {'dari': 'مادربزرگ', 'english': 'grandmother'},
                {'dari': 'عمو', 'english': 'uncle'},
                {'dari': 'خاله', 'english': 'aunt'},
                {'dari': 'پسرعمو', 'english': 'cousin (male)'},
              ],
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'پدربزرگ', 'english': 'grandfather'},
                {'dari': 'مادربزرگ', 'english': 'grandmother'},
                {'dari': 'عمو', 'english': 'uncle'},
                {'dari': 'خاله', 'english': 'aunt'},
              ],
            },
            {
              'type': 'mcqEnglishToDari',
              'english': 'aunt',
              'correct': 'خاله',
              'options': ['عمو', 'خاله', 'پدربزرگ', 'مادربزرگ'],
            },
          ],
        },
      ],
    },
    {
      'id': 2,
      'name': 'Numbers & Time',
      'dari': 'اعداد و زمان',
      'lessons': [
        {
          'name': 'Numbers 1-10',
          'subtitle': 'اعداد ۱ تا ۱۰',
          'xp': 20,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'یک', 'english': 'one'},
                {'dari': 'دو', 'english': 'two'},
                {'dari': 'سه', 'english': 'three'},
                {'dari': 'چهار', 'english': 'four'},
                {'dari': 'پنج', 'english': 'five'},
                {'dari': 'شش', 'english': 'six'},
                {'dari': 'هفت', 'english': 'seven'},
                {'dari': 'هشت', 'english': 'eight'},
                {'dari': 'نه', 'english': 'nine'},
                {'dari': 'ده', 'english': 'ten'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'سه',
              'correct': 'three',
              'options': ['two', 'three', 'four', 'five'],
            },
            {
              'type': 'fillBlank',
              'sentenceParts': ['___', ' کتاب دارم'],
              'blankAnswer': 'دو',
              'altAnswers': ['۲'],
            },
          ],
        },
        {
          'name': 'Days of the Week',
          'subtitle': 'روزهای هفته',
          'xp': 16,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'شنبه', 'english': 'Saturday'},
                {'dari': 'یکشنبه', 'english': 'Sunday'},
                {'dari': 'دوشنبه', 'english': 'Monday'},
                {'dari': 'سه‌شنبه', 'english': 'Tuesday'},
                {'dari': 'چهارشنبه', 'english': 'Wednesday'},
                {'dari': 'پنج‌شنبه', 'english': 'Thursday'},
                {'dari': 'جمعه', 'english': 'Friday'},
              ],
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'شنبه', 'english': 'Saturday'},
                {'dari': 'یکشنبه', 'english': 'Sunday'},
                {'dari': 'دوشنبه', 'english': 'Monday'},
                {'dari': 'سه‌شنبه', 'english': 'Tuesday'},
              ],
            },
            {
              'type': 'mcqEnglishToDari',
              'english': 'Friday',
              'correct': 'جمعه',
              'options': ['شنبه', 'جمعه', 'یکشنبه', 'دوشنبه'],
            },
          ],
        },
      ],
    },
    {
      'id': 3,
      'name': 'Food & Dining',
      'dari': 'غذا و خوردن',
      'lessons': [
        {
          'name': 'Basic Foods',
          'subtitle': 'غذاهای اساسی',
          'xp': 18,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'نان', 'english': 'bread'},
                {'dari': 'برنج', 'english': 'rice'},
                {'dari': 'گوشت', 'english': 'meat'},
                {'dari': 'سبزی', 'english': 'vegetables'},
                {'dari': 'چای', 'english': 'tea'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'چای',
              'correct': 'tea',
              'options': ['coffee', 'tea', 'water', 'juice'],
            },
            {
              'type': 'fillBlank',
              'sentenceParts': ['من ___', ' دوست دارم'],
              'blankAnswer': 'چای',
            },
          ],
        },
        {
          'name': 'Dining Expressions',
          'subtitle': 'عبارات غذایی',
          'xp': 14,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'خوردن', 'english': 'to eat'},
                {'dari': 'نوشیدن', 'english': 'to drink'},
                {'dari': 'گرسنه', 'english': 'hungry'},
                {'dari': 'تشنه', 'english': 'thirsty'},
                {'dari': 'خوشمزه', 'english': 'delicious'},
              ],
            },
            {
              'type': 'trueFalse',
              'statementDari': 'گرسنه',
              'statementEnglish': 'hungry',
              'answer': true,
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'خوردن', 'english': 'to eat'},
                {'dari': 'نوشیدن', 'english': 'to drink'},
                {'dari': 'گرسنه', 'english': 'hungry'},
                {'dari': 'خوشمزه', 'english': 'delicious'},
              ],
            },
          ],
        },
      ],
    },
    {
      'id': 4,
      'name': 'Colors & Descriptions',
      'dari': 'رنگ‌ها و توصیفات',
      'lessons': [
        {
          'name': 'Basic Colors',
          'subtitle': 'رنگ‌های اساسی',
          'xp': 16,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'قرمز', 'english': 'red'},
                {'dari': 'آبی', 'english': 'blue'},
                {'dari': 'سبز', 'english': 'green'},
                {'dari': 'زرد', 'english': 'yellow'},
                {'dari': 'سیاه', 'english': 'black'},
                {'dari': 'سفید', 'english': 'white'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'سبز',
              'correct': 'green',
              'options': ['blue', 'green', 'yellow', 'red'],
            },
            {
              'type': 'fillBlank',
              'sentenceParts': ['آسمان ___', ' است'],
              'blankAnswer': 'آبی',
            },
          ],
        },
        {
          'name': 'Descriptive Words',
          'subtitle': 'کلمات توصیفی',
          'xp': 15,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'بزرگ', 'english': 'big/large'},
                {'dari': 'کوچک', 'english': 'small/little'},
                {'dari': 'خوب', 'english': 'good'},
                {'dari': 'بد', 'english': 'bad'},
                {'dari': 'زیبا', 'english': 'beautiful'},
                {'dari': 'زشت', 'english': 'ugly'},
              ],
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'بزرگ', 'english': 'big'},
                {'dari': 'کوچک', 'english': 'small'},
                {'dari': 'خوب', 'english': 'good'},
                {'dari': 'بد', 'english': 'bad'},
              ],
            },
            {
              'type': 'mcqEnglishToDari',
              'english': 'beautiful',
              'correct': 'زیبا',
              'options': ['زشت', 'زیبا', 'خوب', 'بد'],
            },
          ],
        },
      ],
    },
    {
      'id': 5,
      'name': 'Daily Activities',
      'dari': 'فعالیت‌های روزانه',
      'lessons': [
        {
          'name': 'Morning Routine',
          'subtitle': 'روتین صبحگاهی',
          'xp': 17,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'بیدار شدن', 'english': 'to wake up'},
                {'dari': 'شستن', 'english': 'to wash'},
                {'dari': 'خوردن صبحانه', 'english': 'to eat breakfast'},
                {'dari': 'رفتن', 'english': 'to go'},
                {'dari': 'کار کردن', 'english': 'to work'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'بیدار شدن',
              'correct': 'to wake up',
              'options': ['to sleep', 'to wake up', 'to eat', 'to work'],
            },
            {
              'type': 'fillBlank',
              'sentenceParts': ['من هر روز ___', ''],
              'blankAnswer': 'بیدار می‌شوم',
              'altAnswers': ['بیدار می‌شم'],
            },
          ],
        },
        {
          'name': 'Evening Activities',
          'subtitle': 'فعالیت‌های عصر',
          'xp': 16,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'خوردن شام', 'english': 'to eat dinner'},
                {'dari': 'تماشا کردن', 'english': 'to watch'},
                {'dari': 'خوابیدن', 'english': 'to sleep'},
                {'dari': 'خواندن', 'english': 'to read'},
                {'dari': 'صحبت کردن', 'english': 'to talk'},
              ],
            },
            {
              'type': 'trueFalse',
              'statementDari': 'خوابیدن',
              'statementEnglish': 'to sleep',
              'answer': true,
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'خوردن شام', 'english': 'to eat dinner'},
                {'dari': 'تماشا کردن', 'english': 'to watch'},
                {'dari': 'خوابیدن', 'english': 'to sleep'},
                {'dari': 'خواندن', 'english': 'to read'},
              ],
            },
          ],
        },
      ],
    },
    {
      'id': 6,
      'name': 'Numbers & Counting',
      'dari': 'اعداد و شمارش',
      'lessons': [
        {
          'name': 'Numbers 1-5',
          'subtitle': 'اعداد ۱ تا ۵',
          'xp': 12,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'یک', 'english': 'one'},
                {'dari': 'دو', 'english': 'two'},
                {'dari': 'سه', 'english': 'three'},
                {'dari': 'چهار', 'english': 'four'},
                {'dari': 'پنج', 'english': 'five'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'سه',
              'correct': 'three',
              'options': ['one', 'two', 'three', 'four'],
            },
            {
              'type': 'fillBlank',
              'sentenceParts': ['من ___', ' برادر دارم'],
              'blankAnswer': 'دو',
            },
          ],
        },
        {
          'name': 'Numbers 6-10',
          'subtitle': 'اعداد ۶ تا ۱۰',
          'xp': 13,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'شش', 'english': 'six'},
                {'dari': 'هفت', 'english': 'seven'},
                {'dari': 'هشت', 'english': 'eight'},
                {'dari': 'نه', 'english': 'nine'},
                {'dari': 'ده', 'english': 'ten'},
              ],
            },
            {
              'type': 'mcqEnglishToDari',
              'english': 'eight',
              'correct': 'هشت',
              'options': ['شش', 'هفت', 'هشت', 'نه'],
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'شش', 'english': 'six'},
                {'dari': 'هفت', 'english': 'seven'},
                {'dari': 'هشت', 'english': 'eight'},
                {'dari': 'نه', 'english': 'nine'},
                {'dari': 'ده', 'english': 'ten'},
              ],
            },
          ],
        },
      ],
    },
    {
      'id': 7,
      'name': 'Time & Calendar',
      'dari': 'زمان و تقویم',
      'lessons': [
        {
          'name': 'Days of the Week',
          'subtitle': 'روزهای هفته',
          'xp': 15,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'شنبه', 'english': 'Saturday'},
                {'dari': 'یکشنبه', 'english': 'Sunday'},
                {'dari': 'دوشنبه', 'english': 'Monday'},
                {'dari': 'سه‌شنبه', 'english': 'Tuesday'},
                {'dari': 'چهارشنبه', 'english': 'Wednesday'},
                {'dari': 'پنج‌شنبه', 'english': 'Thursday'},
                {'dari': 'جمعه', 'english': 'Friday'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'جمعه',
              'correct': 'Friday',
              'options': ['Saturday', 'Sunday', 'Friday', 'Monday'],
            },
            {
              'type': 'fillBlank',
              'sentenceParts': ['امروز ___', ' است'],
              'blankAnswer': 'جمعه',
            },
          ],
        },
        {
          'name': 'Time Expressions',
          'subtitle': 'عبارات زمانی',
          'xp': 14,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'صبح', 'english': 'morning'},
                {'dari': 'عصر', 'english': 'afternoon'},
                {'dari': 'شب', 'english': 'night'},
                {'dari': 'امروز', 'english': 'today'},
                {'dari': 'دیروز', 'english': 'yesterday'},
                {'dari': 'فردا', 'english': 'tomorrow'},
              ],
            },
            {
              'type': 'trueFalse',
              'statementDari': 'صبح',
              'statementEnglish': 'morning',
              'answer': true,
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'صبح', 'english': 'morning'},
                {'dari': 'عصر', 'english': 'afternoon'},
                {'dari': 'شب', 'english': 'night'},
                {'dari': 'امروز', 'english': 'today'},
              ],
            },
          ],
        },
      ],
    },
    {
      'id': 8,
      'name': 'Weather & Seasons',
      'dari': 'هوای و فصل‌ها',
      'lessons': [
        {
          'name': 'Weather Conditions',
          'subtitle': 'شرایط هوایی',
          'xp': 16,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'آفتابی', 'english': 'sunny'},
                {'dari': 'ابری', 'english': 'cloudy'},
                {'dari': 'بارانی', 'english': 'rainy'},
                {'dari': 'برفی', 'english': 'snowy'},
                {'dari': 'باد', 'english': 'wind'},
              ],
            },
            {
              'type': 'mcqDariToEnglish',
              'dari': 'بارانی',
              'correct': 'rainy',
              'options': ['sunny', 'cloudy', 'rainy', 'windy'],
            },
            {
              'type': 'fillBlank',
              'sentenceParts': ['امروز هوا ___', ' است'],
              'blankAnswer': 'آفتابی',
            },
          ],
        },
        {
          'name': 'Temperature & Feelings',
          'subtitle': 'دما و احساسات',
          'xp': 13,
          'exercises': [
            {
              'type': 'vocabIntro',
              'words': [
                {'dari': 'گرم', 'english': 'hot'},
                {'dari': 'سرد', 'english': 'cold'},
                {'dari': 'هوای خوب', 'english': 'good weather'},
                {'dari': 'هوای بد', 'english': 'bad weather'},
              ],
            },
            {
              'type': 'trueFalse',
              'statementDari': 'گرم',
              'statementEnglish': 'hot',
              'answer': true,
            },
            {
              'type': 'matching',
              'pairs': [
                {'dari': 'گرم', 'english': 'hot'},
                {'dari': 'سرد', 'english': 'cold'},
                {'dari': 'هوای خوب', 'english': 'good weather'},
                {'dari': 'هوای بد', 'english': 'bad weather'},
              ],
            },
          ],
        },
      ],
    },
  ];

  // Generate code
  final buffer = StringBuffer();
  buffer.writeln('// Add this to _dariUnits in study_curriculum.dart');
  buffer.writeln('  // Classic Dari Units');
  for (final unit in units) {
    final unitId = unit['id'] as int;
    final unitName = unit['name'] as String;
    buffer.writeln('  PathUnit(');
    buffer.writeln('    id: \'dari_classic_u${unitId + 3}\',');
    buffer.writeln('    title: \'$unitName\',');
    buffer.writeln('    lessons: [');

    final lessons = unit['lessons'] as List;
    for (int lessonIndex = 0; lessonIndex < lessons.length; lessonIndex++) {
      final lesson = lessons[lessonIndex];
      final lessonName = lesson['name'] as String;
      final lessonSubtitle = lesson['subtitle'] as String;
      final xp = lesson['xp'] as int;
      buffer.writeln('      PathLesson(');
      buffer.writeln('        id: \'dari_classic_u${unitId}_l$lessonIndex\',');
      buffer.writeln('        title: \'$lessonName\',');
      buffer.writeln('        description: \'$lessonSubtitle\',');
      buffer.writeln('        xpReward: $xp,');
      buffer.writeln('        introPages: const [],');
      buffer.writeln('        exercises: [');

      final exercises = lesson['exercises'] as List;
      int exerciseCount = 0;
      for (final exercise in exercises) {
        final type = exercise['type'] as String;
        if (type == 'vocabIntro') {
          final words = exercise['words'] as List;
          // Collect all dari words from unit for distractors
          final allWords = <String>[];
          for (final l in lessons) {
            final exs = l['exercises'] as List;
            for (final ex in exs) {
              if (ex['type'] == 'vocabIntro') {
                final ws = ex['words'] as List;
                for (final w in ws) {
                  allWords.add(w['dari'] as String);
                }
              }
            }
          }
          for (final word in words) {
            final dari = word['dari'] as String;
            final english = word['english'] as String;
            final distractors = allWords.where((w) => w != dari).take(3).toList();
            final choices = [dari, ...distractors];
            buffer.writeln('          const LessonExercise(');
            buffer.writeln('            id: \'dari_classic_u${unitId}_l${lessonIndex}_v${exerciseCount++}\',');
            buffer.writeln('            kind: ExerciseKind.chooseTranslation,');
            buffer.writeln('            prompt: \'How do you say "$english" in Dari?\',');
            buffer.writeln('            choices: ${jsonEncode(choices)},');
            buffer.writeln('            correctIndex: 0,');
            buffer.writeln('            targetPhrase: \'$dari\',');
            buffer.writeln('          ),');
          }
        } else if (type == 'mcqDariToEnglish') {
          final dari = exercise['dari'] as String;
          final correct = exercise['correct'] as String;
          final options = exercise['options'] as List<String>;
          final correctIndex = options.indexOf(correct);
          buffer.writeln('          const LessonExercise(');
          buffer.writeln('            id: \'dari_classic_u${unitId}_l${lessonIndex}_m${exerciseCount++}\',');
          buffer.writeln('            kind: ExerciseKind.chooseMeaning,');
          buffer.writeln('            prompt: \'What does this mean?\',');
          buffer.writeln('            promptHint: \'$dari\',');
          buffer.writeln('            choices: ${jsonEncode(options)},');
          buffer.writeln('            correctIndex: $correctIndex,');
          buffer.writeln('            targetPhrase: \'$dari\',');
          buffer.writeln('          ),');
        } else if (type == 'mcqEnglishToDari') {
          final english = exercise['english'] as String;
          final correct = exercise['correct'] as String;
          final options = exercise['options'] as List<String>;
          final correctIndex = options.indexOf(correct);
          buffer.writeln('          const LessonExercise(');
          buffer.writeln('            id: \'dari_classic_u${unitId}_l${lessonIndex}_m${exerciseCount++}\',');
          buffer.writeln('            kind: ExerciseKind.chooseTranslation,');
          buffer.writeln('            prompt: \'How do you say "$english" in Dari?\',');
          buffer.writeln('            choices: ${jsonEncode(options)},');
          buffer.writeln('            correctIndex: $correctIndex,');
          buffer.writeln('            targetPhrase: \'$correct\',');
          buffer.writeln('          ),');
        } else if (type == 'dragDropSentence') {
          final dragSentenceParts = exercise['dragSentenceParts'] as List<String>;
          final prompt = 'Arrange: ${dragSentenceParts.join(' ')}';
          final wordBank = exercise['dragWords'] as List<String>;
          final correctOrder = exercise['correctOrder'] as List<String>;
          buffer.writeln('          const LessonExercise(');
          buffer.writeln('            id: \'dari_classic_u${unitId}_l${lessonIndex}_d${exerciseCount++}\',');
          buffer.writeln('            kind: ExerciseKind.arrangeWords,');
          buffer.writeln('            prompt: ${jsonEncode(prompt)},');
          buffer.writeln('            wordBank: ${jsonEncode(wordBank)},');
          buffer.writeln('            correctWordOrder: ${jsonEncode(correctOrder)},');
          buffer.writeln('          ),');
        } else if (type == 'trueFalse') {
          final statementDari = exercise['statementDari'] as String;
          final statementEnglish = exercise['statementEnglish'] as String;
          final answer = exercise['answer'] as bool;
          final correctIndex = answer ? 0 : 1;
          buffer.writeln('          const LessonExercise(');
          buffer.writeln('            id: \'dari_classic_u${unitId}_l${lessonIndex}_t${exerciseCount++}\',');
          buffer.writeln('            kind: ExerciseKind.chooseTranslation,');
          buffer.writeln('            prompt: \'Is "$statementEnglish" correct for "$statementDari"?\',');
          buffer.writeln('            choices: ${jsonEncode(['Yes', 'No'])},');
          buffer.writeln('            correctIndex: $correctIndex,');
          buffer.writeln('            targetPhrase: \'$statementDari\',');
          buffer.writeln('          ),');
        } else if (type == 'matching') {
          final pairs = exercise['pairs'] as List;
          for (final pair in pairs) {
            final dari = pair['dari'] as String;
            final english = pair['english'] as String;
            final distractors = pairs.where((p) => p['dari'] != dari).map((p) => p['dari'] as String).take(3).toList();
            final choices = [dari, ...distractors];
            buffer.writeln('          const LessonExercise(');
            buffer.writeln('            id: \'dari_classic_u${unitId}_l${lessonIndex}_ma${exerciseCount++}\',');
            buffer.writeln('            kind: ExerciseKind.chooseTranslation,');
            buffer.writeln('            prompt: \'How do you say "$english" in Dari?\',');
            buffer.writeln('            choices: ${jsonEncode(choices)},');
            buffer.writeln('            correctIndex: 0,');
            buffer.writeln('            targetPhrase: \'$dari\',');
            buffer.writeln('          ),');
          }
        } else if (type == 'fillBlank') {
          final sentenceParts = exercise['sentenceParts'] as List<String>;
          final prompt = 'Fill: ${sentenceParts.join(' ')}';
          final blankAnswer = exercise['blankAnswer'] as String;
          final altAnswers = exercise['altAnswers'] as List<String>? ?? [];
          final choices = [blankAnswer, ...altAnswers];
          buffer.writeln('          const LessonExercise(');
          buffer.writeln('            id: \'dari_classic_u${unitId}_l${lessonIndex}_f${exerciseCount++}\',');
          buffer.writeln('            kind: ExerciseKind.chooseTranslation,');
          buffer.writeln('            prompt: ${jsonEncode(prompt)},');
          buffer.writeln('            choices: ${jsonEncode(choices)},');
          buffer.writeln('            correctIndex: 0,');
          buffer.writeln('            targetPhrase: \'$blankAnswer\',');
          buffer.writeln('          ),');
        }
        // Skip other types
      }
      buffer.writeln('        ],');
      buffer.writeln('      ),');
    }
    buffer.writeln('    ],');
    buffer.writeln('  ),');
  }

  // ignore: avoid_print
  print(buffer.toString());
}