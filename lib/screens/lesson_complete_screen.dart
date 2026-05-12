import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class LessonCompleteScreen extends StatefulWidget {
  const LessonCompleteScreen({
    super.key,
    required this.title,
    required this.xpEarned,
    required this.onContinue,
    this.heartsRemaining = 5,
  });

  final String title;
  final int xpEarned;
  final VoidCallback onContinue;
  final int heartsRemaining;

  @override
  State<LessonCompleteScreen> createState() => _LessonCompleteScreenState();
}

class _LessonCompleteScreenState extends State<LessonCompleteScreen>
    with TickerProviderStateMixin {
  late AnimationController _trophy;
  late Animation<double> _trophyScale;

  late AnimationController _confettiCtrl;
  final List<_Confetti> _pieces = [];
  final Random _rng = Random();

  @override
  void initState() {
    super.initState();

    _trophy = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _trophyScale = CurvedAnimation(parent: _trophy, curve: Curves.elasticOut);

    _confettiCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..addListener(() => setState(() {}));

    // Spawn confetti pieces
    for (var i = 0; i < 38; i++) {
      _pieces.add(_Confetti(rng: _rng));
    }

    _trophy.forward();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _confettiCtrl.forward();
    });
  }

  @override
  void dispose() {
    _trophy.dispose();
    _confettiCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.leaf.withValues(alpha: 0.18),
                  AppTheme.zabonGold.withValues(alpha: 0.12),
                  AppTheme.paper,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Confetti layer
          if (_confettiCtrl.isAnimating || _confettiCtrl.isCompleted)
            ...(_pieces.map((p) => p.build(size, _confettiCtrl.value))),

          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  ScaleTransition(
                    scale: _trophyScale,
                    child: Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.leaf.withValues(alpha: 0.35),
                            blurRadius: 28,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.emoji_events_rounded,
                        size: 72,
                        color: AppTheme.zabonGold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Lesson complete!',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.zabonNavy,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Colors.grey.shade700,
                        ),
                  ),
                  const Spacer(),

                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _StatBadge(
                        icon: Icons.bolt_rounded,
                        color: AppTheme.zabonGold,
                        label: 'XP',
                        valueWidget: TweenAnimationBuilder<int>(
                          tween: IntTween(begin: 0, end: widget.xpEarned),
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeOutCubic,
                          builder: (context, v, child) => Text(
                            '+$v',
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              color: AppTheme.zabonNavy,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      _StatBadge(
                        icon: Icons.favorite_rounded,
                        color: Colors.red.shade400,
                        label: 'Hearts',
                        valueWidget: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(5, (i) => Icon(
                            i < widget.heartsRemaining
                                ? Icons.favorite_rounded
                                : Icons.favorite_border_rounded,
                            color: i < widget.heartsRemaining
                                ? Colors.red.shade400
                                : Colors.grey.shade300,
                            size: 20,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Great work — keep your streak alive!',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade600,
                        ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: widget.onContinue,
                      child: const Text('CONTINUE'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBadge extends StatelessWidget {
  const _StatBadge({
    required this.icon,
    required this.color,
    required this.label,
    required this.valueWidget,
  });

  final IconData icon;
  final Color color;
  final String label;
  final Widget valueWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          valueWidget,
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade500,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Confetti particle ────────────────────────────────────────────────────────

class _Confetti {
  _Confetti({required Random rng})
      : x = rng.nextDouble(),
        delay = rng.nextDouble() * 0.35,
        speed = 0.55 + rng.nextDouble() * 0.45,
        size = 6 + rng.nextDouble() * 8,
        angle = rng.nextDouble() * pi * 2,
        spin = (rng.nextDouble() - 0.5) * 8,
        drift = (rng.nextDouble() - 0.5) * 0.3,
        color = _palette[rng.nextInt(_palette.length)];

  static const List<Color> _palette = [
    Color(0xFF58CC02),
    Color(0xFFFFB800),
    Color(0xFF1CB0F6),
    Color(0xFFFF4B4B),
    Color(0xFFCE82FF),
    Color(0xFFFF9600),
    Color(0xFF2BDBA9),
  ];

  final double x;
  final double delay;
  final double speed;
  final double size;
  final double angle;
  final double spin;
  final double drift;
  final Color color;

  Widget build(Size screen, double t) {
    final adjusted = ((t - delay) / (1 - delay)).clamp(0.0, 1.0);
    if (adjusted <= 0) return const SizedBox.shrink();

    final py = adjusted * speed;
    final px = x + sin(adjusted * pi * 2.5) * drift;
    final rot = angle + adjusted * spin;
    final opacity = adjusted > 0.75 ? 1 - (adjusted - 0.75) / 0.25 : 1.0;

    return Positioned(
      left: px * screen.width,
      top: py * screen.height * 1.1,
      child: Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: Transform.rotate(
          angle: rot,
          child: Container(
            width: size,
            height: size * 0.5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ),
    );
  }
}
