import 'package:flutter/material.dart';
import '../data/dari_phrases.dart';
import '../models/phrase.dart';

class PhrasesPage extends StatefulWidget {
  const PhrasesPage({super.key});

  @override
  State<PhrasesPage> createState() => _PhrasesPageState();
}

class _PhrasesPageState extends State<PhrasesPage> {
  String selectedCategory = 'greetings';
  Phrase? selectedPhrase;

  @override
  Widget build(BuildContext context) {
    final category = dariPhraseCategories.firstWhere(
      (cat) => cat.id == selectedCategory,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EE),
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: const Color(0xFF1A1208),
        title: const Text('Common Phrases'),
      ),
      body: Column(
        children: [
          // Category selector
          Container(
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: dariPhraseCategories.length,
              itemBuilder: (context, index) {
                final cat = dariPhraseCategories[index];
                final isSelected = cat.id == selectedCategory;

                return Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Row(
                      children: [
                        Text(cat.icon),
                        const SizedBox(width: 4),
                        Text(cat.name),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          selectedCategory = cat.id;
                          selectedPhrase = null;
                        });
                      }
                    },
                    backgroundColor: isSelected ? const Color(0xFFC9922A) : Colors.white,
                    selectedColor: const Color(0xFFC9922A),
                    checkmarkColor: Colors.white,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),

          // Phrase list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: category.phrases.length,
              itemBuilder: (context, index) {
                final phrase = category.phrases[index];
                final isSelected = selectedPhrase == phrase;

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: isSelected ? const Color(0xFFE8F4FD) : Colors.white,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedPhrase = isSelected ? null : phrase;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Dari text
                          Text(
                            phrase.dari,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF8B4513),
                            ),
                            textDirection: TextDirection.rtl,
                          ),

                          // Phonetic
                          Text(
                            phrase.phonetic,
                            style: const TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey,
                            ),
                          ),

                          const SizedBox(height: 4),

                          // English translation
                          Text(
                            phrase.english,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),

                          // Difficulty badge
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: phrase.difficulty == 'beginner'
                                  ? Colors.green.shade100
                                  : phrase.difficulty == 'intermediate'
                                      ? Colors.orange.shade100
                                      : Colors.red.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              phrase.difficulty,
                              style: TextStyle(
                                fontSize: 12,
                                color: phrase.difficulty == 'beginner'
                                    ? Colors.green.shade800
                                    : phrase.difficulty == 'intermediate'
                                        ? Colors.orange.shade800
                                        : Colors.red.shade800,
                              ),
                            ),
                          ),

                          // Expanded content when selected
                          if (isSelected) ...[
                            const SizedBox(height: 16),
                            const Divider(),
                            const SizedBox(height: 8),

                            // Practice section
                            const Text(
                              'Practice this phrase:',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),

                            // Speak button
                            Center(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  // For now, just show a snackbar since we don't have TTS
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Playing: ${phrase.phonetic}'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.volume_up),
                                label: const Text('Listen'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFC9922A),
                                  foregroundColor: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Record button (placeholder)
                            Center(
                              child: OutlinedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Recording feature coming soon!'),
                                      duration: Duration(seconds: 2),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.mic),
                                label: const Text('Practice Speaking'),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
