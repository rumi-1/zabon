import 'package:flutter/material.dart';
import '../models/unit.dart';

class UnitCard extends StatelessWidget {
  final Unit unit;
  final int completedLessons;
  final VoidCallback? onTap;

  const UnitCard({
    super.key,
    required this.unit,
    required this.completedLessons,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final total = unit.lessons.length;
    final done = completedLessons;
    final isDone = done >= total && total > 0;
    final opacity = unit.locked ? 0.45 : 1.0;

    return Opacity(
      opacity: opacity,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0x221A3A5C)),
          ),
          child: Row(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF0F7),
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  unit.iconText,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF1A3A5C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      unit.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      unit.dari,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8A7A58),
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$done/$total lessons',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A7A58),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: unit.locked
                      ? const Color(0xFFF5EDD8)
                      : isDone
                          ? const Color(0xFFEAF3EE)
                          : done > 0
                              ? const Color(0xFFEAF0F7)
                              : const Color(0xFFFBF0DC),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  unit.locked
                      ? 'LOCKED'
                      : isDone
                          ? 'DONE'
                          : done > 0
                              ? 'CONTINUE'
                              : 'START',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}