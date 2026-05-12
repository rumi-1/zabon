import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/dari_units.dart';
import '../state/app_state.dart';
import '../widgets/unit_card.dart';
import 'unit_page.dart';

/// Original Zabon unit list (vocabulary-style lessons) — kept alongside the new path.
class LegacyUnitsPage extends StatelessWidget {
  const LegacyUnitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Classic units'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        children: [
          Text(
            'First-generation lesson layout: rich vocabulary cards, MCQ, and drag-and-drop. '
            'Your progress is still saved.',
            style: TextStyle(
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 16),
          ...dariUnits.map(
            (unit) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: UnitCard(
                unit: unit.copyWith(
                  locked: unit.id > 0 &&
                      appState.completedCountForUnit(unit.id - 1) <
                          dariUnits[unit.id - 1].lessons.length,
                ),
                completedLessons: appState.completedCountForUnit(unit.id),
                onTap: (unit.id == 0 ||
                        appState.completedCountForUnit(unit.id - 1) >=
                            dariUnits[unit.id - 1].lessons.length)
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (_) => UnitPage(unit: unit),
                          ),
                        );
                      }
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
