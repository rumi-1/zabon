import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/dari_units.dart';
import '../state/app_state.dart';
import '../widgets/unit_card.dart';
import 'unit_page.dart';
import 'alphabet_page.dart';
import 'phrases_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
              children: [
                const Text(
                  'Learn\nDari Persian',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A3A5C),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'یاد گرفتن فارسی دری',
                  style: TextStyle(
                    fontSize: 22,
                    color: Color(0xFFC9922A),
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A3A5C),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Continue learning',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        dariUnits.first.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '${appState.completedCountForUnit(dariUnits.first.id)}/${dariUnits.first.lessons.length} lessons done',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'UNITS',
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 2,
                    color: Color(0xFF8A7A58),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                ...dariUnits.map(
                  (unit) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: UnitCard(
                      unit: unit,
                      completedLessons: appState.completedCountForUnit(unit.id),
                      onTap: unit.locked
                          ? null
                          : () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => UnitPage(unit: unit),
                                ),
                              );
                            },
                    ),
                  ),
                ),
              ],
            ),
            const AlphabetPage(),
            const PhrasesPage(),
            const ProfilePage(),
          ],
        ),
        bottomNavigationBar: const _HomeTabs(),
      ),
    );
  }
}

class _HomeTabs extends StatelessWidget {
  const _HomeTabs();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFBF6EE),
      child: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.home_outlined), text: 'Learn'),
          Tab(icon: Icon(Icons.translate), text: 'Script'),
          Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Phrases'),
          Tab(icon: Icon(Icons.person_outline), text: 'Profile'),
        ],
      ),
    );
  }
}