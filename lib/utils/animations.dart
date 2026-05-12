import 'package:flutter/material.dart';

class AppAnimations {
  static Widget slideInFromBottom(Widget child, {Duration duration = const Duration(milliseconds: 500)}) {
    return TweenAnimationBuilder(
      tween: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero),
      duration: duration,
      builder: (context, offset, child) {
        return Transform.translate(
          offset: offset,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget scaleIn(Widget child, {Duration duration = const Duration(milliseconds: 300)}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.8, end: 1.0),
      duration: duration,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget bounceIn(Widget child, {Duration duration = const Duration(milliseconds: 600)}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.3, end: 1.0),
      duration: duration,
      curve: Curves.elasticOut,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget fadeIn(Widget child, {Duration duration = const Duration(milliseconds: 400)}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: duration,
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: child,
    );
  }

  static Widget successAnimation({required VoidCallback onComplete}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 800),
      onEnd: onComplete,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 100 + (value * 50),
              height: 100 + (value * 50),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green.withValues(alpha: 0.3 * (1 - value)),
              ),
            ),
            Icon(
              Icons.check_circle,
              size: 60 + (value * 20),
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }

  static Widget errorAnimation({required VoidCallback onComplete}) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      onEnd: onComplete,
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 80 + (value * 40),
              height: 80 + (value * 40),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withValues(alpha: 0.3 * (1 - value)),
              ),
            ),
            Icon(
              Icons.cancel,
              size: 50 + (value * 15),
              color: Colors.red,
            ),
          ],
        );
      },
    );
  }
}