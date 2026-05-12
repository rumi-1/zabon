import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/study_models.dart';
import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../utils/sound_service.dart';
import '../widgets/exercises/exercise_panel.dart';
import '../widgets/motion/shake.dart';
import '../widgets/motion/slide_fade.dart';
import 'lesson_complete_screen.dart';

class ExerciseSessionScreen extends StatefulWidget {
  const ExerciseSessionScreen({
    super.key,
    required this.language,
    required this.title,
    required this.exercises,
    this.introPages = const [],
    this.lessonId,
    required this.xpReward,
  });

  final StudyLanguage language;
  final String title;
  final List<LessonExercise> exercises;
  final List<String> introPages;
  final String? lessonId;
  final int xpReward;

  @override
  State<ExerciseSessionScreen> createState() => _ExerciseSessionScreenState();
}

class _ExerciseSessionScreenState extends State<ExerciseSessionScreen>
    with TickerProviderStateMixin {
  late int _phase;
  int _hearts = 5;
  int _combo = 0;

  int? _selectedChoice;
  bool _showChoiceResult = false;

  List<String> _wordAvailable = [];
  List<String> _wordPicked = [];
  bool _wordShowResult = false;
  int _shakeTick = 0;

  // Combo pop animation
  late AnimationController _comboBump;
  late Animation<double> _comboBumpScale;

  // Heart shake animation controller
  late AnimationController _heartAnim;
  late Animation<double> _heartShake;

  int get _introCount => widget.introPages.length;
  bool get _inIntro => _introCount > 0 && _phase < _introCount;
  int get _exIndex => _phase - _introCount;
  int get _totalPhases => _introCount + widget.exercises.length;

  LessonExercise? get _currentEx =>
      !_inIntro && _exIndex < widget.exercises.length
          ? widget.exercises[_exIndex]
          : null;

  @override
  void initState() {
    super.initState();
    _phase = 0;

    _comboBump = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _comboBumpScale = CurvedAnimation(parent: _comboBump, curve: Curves.elasticOut);

    _heartAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _heartShake = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: -6.0), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -6.0, end: 6.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 6.0, end: -4.0), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -4.0, end: 0.0), weight: 1),
    ]).animate(_heartAnim);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final ex = _currentEx;
      if (ex?.kind == ExerciseKind.arrangeWords && _wordAvailable.isEmpty) {
        setState(() => _prepareWordOrder(ex!));
      }
    });
  }

  @override
  void dispose() {
    _comboBump.dispose();
    _heartAnim.dispose();
    super.dispose();
  }

  void _prepareWordOrder(LessonExercise ex) {
    final bank = ex.wordBank;
    final order = ex.correctWordOrder;
    if (bank != null && order != null) {
      _wordAvailable = shuffledWords(bank);
      _wordPicked = [];
      _wordShowResult = false;
    }
  }

  void _advancePhase() {
    setState(() {
      _phase++;
      _resetExerciseState();
      final ex = _currentEx;
      if (ex?.kind == ExerciseKind.arrangeWords) {
        _prepareWordOrder(ex!);
      }
    });
  }

  void _resetExerciseState() {
    _selectedChoice = null;
    _showChoiceResult = false;
    _wordShowResult = false;
    _wordPicked = [];
    _wordAvailable = [];
  }

  bool _choiceExerciseReady(LessonExercise ex) {
    switch (ex.kind) {
      case ExerciseKind.chooseTranslation:
      case ExerciseKind.chooseMeaning:
      case ExerciseKind.listening:
        return _selectedChoice != null;
      case ExerciseKind.arrangeWords:
        final order = ex.correctWordOrder;
        return order != null && _wordPicked.length == order.length;
    }
  }

  bool _evaluateWordOrder(LessonExercise ex) {
    final order = ex.correctWordOrder;
    if (order == null) return false;
    if (_wordPicked.length != order.length) return false;
    for (var i = 0; i < order.length; i++) {
      if (_wordPicked[i] != order[i]) return false;
    }
    return true;
  }

  Future<void> _onCheck() async {
    final ex = _currentEx;
    if (ex == null) return;

    if (ex.kind == ExerciseKind.arrangeWords) {
      final ok = _evaluateWordOrder(ex);
      setState(() => _wordShowResult = true);
      if (ok) {
        _onCorrect();
      } else {
        await _onWrong();
      }
      return;
    }

    final ok = _selectedChoice == ex.correctIndex;
    setState(() => _showChoiceResult = true);
    if (ok) {
      _onCorrect();
    } else {
      await _onWrong();
    }
  }

  void _onCorrect() {
    SoundService.instance.playCorrect();
    setState(() {
      _combo++;
      _comboBump.forward(from: 0);
    });
  }

  Future<void> _onWrong() async {
    SoundService.instance.playWrong();
    setState(() {
      _combo = 0;
      _hearts = (_hearts - 1).clamp(0, 5);
      _shakeTick++;
    });
    _heartAnim.forward(from: 0);

    if (_hearts <= 0) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Take a breather'),
          content: const Text(
            'You ran out of hearts for this lesson. Try again when you are ready.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Exit'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                setState(() {
                  _hearts = 5;
                  _combo = 0;
                  _phase = _introCount;
                  _resetExerciseState();
                  final ex = _currentEx;
                  if (ex?.kind == ExerciseKind.arrangeWords) {
                    _prepareWordOrder(ex!);
                  }
                });
              },
              child: const Text('Restart'),
            ),
          ],
        ),
      );
    }
  }

  void _tryAgain() {
    setState(() {
      final ex = _currentEx;
      if (ex == null) return;
      if (ex.kind == ExerciseKind.arrangeWords) {
        _prepareWordOrder(ex);
      } else {
        _selectedChoice = null;
        _showChoiceResult = false;
      }
      _wordShowResult = false;
    });
  }

  bool get _currentCorrect {
    final ex = _currentEx;
    if (ex == null) return false;
    if (ex.kind == ExerciseKind.arrangeWords) {
      return _wordShowResult && _evaluateWordOrder(ex);
    }
    return _showChoiceResult && _selectedChoice == ex.correctIndex;
  }

  bool get _currentWrongVisible {
    final ex = _currentEx;
    if (ex == null) return false;
    if (ex.kind == ExerciseKind.arrangeWords) {
      return _wordShowResult && !_evaluateWordOrder(ex);
    }
    return _showChoiceResult && _selectedChoice != ex.correctIndex;
  }

  Future<void> _onContinueIntro() async {
    if (_phase < _introCount - 1) {
      setState(() => _phase++);
    } else {
      setState(() {
        _phase = _introCount;
        _resetExerciseState();
        final ex = _currentEx;
        if (ex?.kind == ExerciseKind.arrangeWords) {
          _prepareWordOrder(ex!);
        }
      });
    }
  }

  Future<void> _onContinueAfterExercise() async {
    if (_exIndex < widget.exercises.length - 1) {
      _advancePhase();
    } else {
      await _completeSession();
    }
  }

  Future<void> _completeSession() async {
    SoundService.instance.playComplete();
    final app = context.read<AppState>();
    if (widget.lessonId != null) {
      await app.completePathLesson(widget.lessonId!, widget.xpReward);
    } else {
      await app.recordPracticeSession(widget.xpReward);
    }
    if (!mounted) return;
    await Navigator.of(context).push<void>(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 450),
        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
          opacity: animation,
          child: LessonCompleteScreen(
            title: widget.title,
            xpEarned: widget.xpReward,
            heartsRemaining: _hearts,
            onContinue: () {
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_phase +
            (_inIntro ? 0.15 : (_currentCorrect ? 0.95 : 0.4))) /
        _totalPhases.clamp(1, 999);

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          leading: IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => _confirmExit(context),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: AnimatedBuilder(
                animation: _heartShake,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(_heartShake.value, 0),
                    child: child,
                  );
                },
                child: Row(
                  children: List.generate(5, (i) {
                    final alive = i < _hearts;
                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, anim) => ScaleTransition(
                        scale: anim,
                        child: child,
                      ),
                      child: Padding(
                        key: ValueKey('heart_${i}_$alive'),
                        padding: const EdgeInsets.only(left: 2),
                        child: Icon(
                          alive ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: alive ? Colors.red.shade400 : Colors.grey.shade300,
                          size: 22,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Row(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, _) {
                          return LinearProgressIndicator(
                            value: value,
                            minHeight: 10,
                            backgroundColor: Colors.grey.shade200,
                            color: AppTheme.leaf,
                          );
                        },
                      ),
                    ),
                  ),
                  if (_combo >= 3) ...[
                    const SizedBox(width: 10),
                    ScaleTransition(
                      scale: _comboBumpScale,
                      child: _ComboChip(combo: _combo),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: SlideFadeSwitcher(
                  child: _inIntro
                      ? _IntroPage(
                          key: ValueKey('intro_$_phase'),
                          text: widget.introPages[_phase],
                          language: widget.language,
                        )
                      : _currentEx != null
                          ? Shake(
                              key: ValueKey('shake_$_phase'),
                              shakeTick: _shakeTick,
                              child: ExercisePanel(
                                key: ValueKey('ex_${_currentEx!.id}'),
                                exercise: _currentEx!,
                                language: widget.language,
                                enabled: !_currentCorrect,
                                selectedIndex: _selectedChoice,
                                showResult:
                                    _showChoiceResult || _wordShowResult,
                                wasWrong: _currentWrongVisible,
                                onSelectChoice: (i) {
                                  if (_currentCorrect) return;
                                  SoundService.instance.playTap();
                                  setState(() {
                                    _selectedChoice = i;
                                    _showChoiceResult = false;
                                  });
                                },
                                wordAvailable: _wordAvailable,
                                wordPicked: _wordPicked,
                                onPickWord: (w) {
                                  if (_currentCorrect) return;
                                  SoundService.instance.playTap();
                                  setState(() {
                                    _wordAvailable.remove(w);
                                    _wordPicked.add(w);
                                    _wordShowResult = false;
                                  });
                                },
                                onUnpickWord: (w) {
                                  if (_currentCorrect) return;
                                  setState(() {
                                    _wordPicked.remove(w);
                                    _wordAvailable.add(w);
                                    _wordShowResult = false;
                                  });
                                },
                                wordOrderCorrect: _currentEx!.kind ==
                                            ExerciseKind.arrangeWords &&
                                        _wordShowResult
                                    ? _evaluateWordOrder(_currentEx!)
                                    : null,
                              ),
                            )
                          : const SizedBox.shrink(),
                ),
              ),
            ),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    if (_inIntro) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _onContinueIntro,
              child: Text(
                _phase < _introCount - 1 ? 'CONTINUE' : 'START LESSON',
              ),
            ),
          ),
        ),
      );
    }

    final ex = _currentEx;
    if (ex == null) return const SizedBox.shrink();

    final ready = _choiceExerciseReady(ex);
    final correct = _currentCorrect;
    final wrong = _currentWrongVisible;

    return SafeArea(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
        decoration: BoxDecoration(
          color: correct
              ? const Color(0xFFD7FFB8)
              : wrong
                  ? const Color(0xFFFFDFDF)
                  : Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 14,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (correct) ...[
              Row(
                children: [
                  Icon(Icons.check_circle_rounded, color: AppTheme.leafDark, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    _combo >= 3 ? '🔥 ${_combo}x combo!' : 'Correct!',
                    style: TextStyle(
                      color: AppTheme.leafDark,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ] else if (wrong) ...[
              Row(
                children: [
                  Icon(Icons.cancel_rounded, color: Colors.red.shade600, size: 22),
                  const SizedBox(width: 8),
                  Text(
                    'Not quite — try again!',
                    style: TextStyle(
                      color: Colors.red.shade700,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
            Row(
              children: [
                if (wrong && _hearts > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _tryAgain,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.red.shade400, width: 2),
                        foregroundColor: Colors.red.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('TRY AGAIN',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ),
                  ),
                if (wrong && _hearts > 0) const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: correct
                        ? _onContinueAfterExercise
                        : wrong
                            ? null
                            : !ready
                                ? null
                                : _onCheck,
                    style: FilledButton.styleFrom(
                      backgroundColor: correct
                          ? AppTheme.leafDark
                          : wrong
                              ? Colors.grey.shade400
                              : AppTheme.leaf,
                    ),
                    child: Text(correct ? 'CONTINUE' : 'CHECK'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmExit(BuildContext context) async {
    final leave = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Leave lesson?'),
        content: const Text('Progress in this session will be lost.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Stay'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Leave'),
          ),
        ],
      ),
    );
    if (leave == true && context.mounted) {
      Navigator.of(context).pop();
    }
  }
}

class _ComboChip extends StatelessWidget {
  const _ComboChip({required this.combo});
  final int combo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF9500), Color(0xFFFF3B30)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('🔥', style: TextStyle(fontSize: 14)),
          const SizedBox(width: 3),
          Text(
            '$combo',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroPage extends StatelessWidget {
  const _IntroPage({
    super.key,
    required this.text,
    required this.language,
  });

  final String text;
  final StudyLanguage language;

  @override
  Widget build(BuildContext context) {
    if (text == 'NUMBERS_TILES_PAGE') {
      return _NumbersTilesPage(language: language);
    }

    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.auto_stories_rounded, color: AppTheme.sky),
                  const SizedBox(width: 8),
                  Text(
                    language == StudyLanguage.dari ? 'Dari' : 'Pashto',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.zabonNavy,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                text,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      height: 1.45,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumbersTilesPage extends StatelessWidget {
  const _NumbersTilesPage({required this.language});

  final StudyLanguage language;

  static const List<Map<String, String>> _dariNumbers = [
    {'script': 'صفر', 'roman': 'sifr', 'english': '0'},
    {'script': 'یک', 'roman': 'yak', 'english': '1'},
    {'script': 'دو', 'roman': 'do', 'english': '2'},
    {'script': 'سه', 'roman': 'se', 'english': '3'},
    {'script': 'چهار', 'roman': 'châr', 'english': '4'},
    {'script': 'پنج', 'roman': 'panj', 'english': '5'},
    {'script': 'شش', 'roman': 'shash', 'english': '6'},
    {'script': 'هفت', 'roman': 'haft', 'english': '7'},
    {'script': 'هشت', 'roman': 'hasht', 'english': '8'},
    {'script': 'نه', 'roman': 'no', 'english': '9'},
    {'script': 'ده', 'roman': 'dah', 'english': '10'},
  ];

  // Afghan Standard Literary Pashto numbers
  // Note: نه (na) = 9 but also means "no" — distinguished by context
  static const List<Map<String, String>> _pashtoNumbers = [
    {'script': 'صفر', 'roman': 'sifr', 'english': '0'},
    {'script': 'یو', 'roman': 'yo', 'english': '1'},
    {'script': 'دوه', 'roman': 'dwa', 'english': '2'},
    {'script': 'درې', 'roman': 'dre', 'english': '3'},
    {'script': 'څلور', 'roman': 'tsalor', 'english': '4'},
    {'script': 'پنځه', 'roman': 'pinza', 'english': '5'},
    {'script': 'شپږ', 'roman': 'shpag', 'english': '6'},
    {'script': 'اووه', 'roman': 'owa', 'english': '7'},
    {'script': 'اته', 'roman': 'ata', 'english': '8'},
    {'script': 'نه', 'roman': 'na', 'english': '9'},
    {'script': 'لس', 'roman': 'las', 'english': '10'},
  ];

  @override
  Widget build(BuildContext context) {
    final isDari = language == StudyLanguage.dari;
    final numbers = isDari ? _dariNumbers : _pashtoNumbers;
    final dialect = isDari ? 'Kabul Dari' : 'Afghan Pashto';
    final note = isDari
        ? 'Note "shash" (6), "no" (9), "yak" (1) — differ from Iranian Persian.'
        : 'Note: نه (na) = 9 in Pashto, and also means "no". Context tells them apart.';

    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.calculate_rounded, color: AppTheme.sky),
                  const SizedBox(width: 8),
                  Text(
                    'Numbers 0–10 · $dialect',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.zabonNavy,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Tap any tile. $note',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.4,
                      color: Colors.grey.shade700,
                    ),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: numbers.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  return _NumberTile(number: numbers[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NumberTile extends StatefulWidget {
  const _NumberTile({required this.number});
  final Map<String, String> number;

  @override
  State<_NumberTile> createState() => _NumberTileState();
}

class _NumberTileState extends State<_NumberTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  bool _tapped = false;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _scale = CurvedAnimation(parent: _ctrl, curve: Curves.elasticOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _onTap() {
    SoundService.instance.playTap();
    setState(() => _tapped = !_tapped);
    _ctrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: ScaleTransition(
        scale: Tween(begin: 1.0, end: 1.12).animate(_scale),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: _tapped
                ? AppTheme.leaf.withValues(alpha: 0.12)
                : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _tapped
                  ? AppTheme.leaf
                  : AppTheme.zabonNavy.withValues(alpha: 0.1),
              width: _tapped ? 2 : 1,
            ),
            boxShadow: _tapped
                ? [
                    BoxShadow(
                      color: AppTheme.leaf.withValues(alpha: 0.2),
                      blurRadius: 8,
                    ),
                  ]
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.number['script']!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: _tapped ? AppTheme.leafDark : AppTheme.zabonNavy,
                ),
                textDirection: TextDirection.rtl,
              ),
              const SizedBox(height: 4),
              Text(
                widget.number['roman']!,
                style: TextStyle(
                  fontSize: 12,
                  color: _tapped ? AppTheme.leafDark : Colors.grey.shade600,
                  fontWeight: _tapped ? FontWeight.w700 : FontWeight.normal,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                widget.number['english']!,
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
