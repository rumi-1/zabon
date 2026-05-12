import 'package:flutter/material.dart';

import 'alphabet_page.dart';
import 'path_page.dart';
import 'phrases_page.dart';
import 'practice_page.dart';
import 'profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            PathPage(),
            PracticePage(),
            AlphabetPage(),
            PhrasesPage(),
            ProfilePage(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 12,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: const SafeArea(
            child: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.map_rounded), text: 'Path'),
                Tab(icon: Icon(Icons.flash_on_rounded), text: 'Practice'),
                Tab(icon: Icon(Icons.translate), text: 'Script'),
                Tab(icon: Icon(Icons.chat_bubble_outline), text: 'Phrases'),
                Tab(icon: Icon(Icons.person_outline), text: 'Profile'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
