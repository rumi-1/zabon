import 'package:flutter/material.dart';
import '../data/dari_alphabet.dart';
import '../models/alphabet_letter.dart';
import '../services/audio_service.dart';

class AlphabetPage extends StatefulWidget {
  const AlphabetPage({super.key});

  @override
  State<AlphabetPage> createState() => _AlphabetPageState();
}

class _AlphabetPageState extends State<AlphabetPage> {
  AlphabetLetter? selectedLetter;

  Future<void> _selectLetter(AlphabetLetter letter) async {
    setState(() {
      selectedLetter = letter;
    });

    await AudioService.instance.playAlphabetSound(letter.audioFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFBF6EE),
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: const Color(0xFF1A1208),
        title: const Text('Dari Alphabet'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${dariAlphabet.length} letters · tap a letter to hear it',
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xFF8A7A58),
            ),
          ),
          const SizedBox(height: 16),

          if (selectedLetter != null) ...[
            _AlphabetDetailCard(
              letter: selectedLetter!,
              onPlay: () async {
                await AudioService.instance
                    .playAlphabetSound(selectedLetter!.audioFile);
              },
            ),
            const SizedBox(height: 16),
          ],

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dariAlphabet.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemBuilder: (context, index) {
              final letter = dariAlphabet[index];
              final isSelected = selectedLetter?.symbol == letter.symbol;

              return InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () => _selectLetter(letter),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFFEAF0F7)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF1A3A5C)
                          : const Color(0x221A3A5C),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        letter.symbol,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1A3A5C),
                        ),
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        letter.name,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color(0xFF8A7A58),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _AlphabetDetailCard extends StatelessWidget {
  final AlphabetLetter letter;
  final VoidCallback onPlay;

  const _AlphabetDetailCard({
    required this.letter,
    required this.onPlay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0x221A3A5C)),
      ),
      child: Column(
        children: [
          Text(
            letter.symbol,
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A3A5C),
            ),
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 8),
          Text(
            letter.name,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF1A3A5C),
            ),
          ),
          Text(
            letter.sound,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFFC9922A),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: onPlay,
            icon: const Icon(Icons.volume_up),
            label: const Text('Play Sound'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A3A5C),
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
