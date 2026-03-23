import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dari App',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF6F2EA),
        fontFamily: 'Roboto',
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          children: [
            const SectionTitle("UNITS"),
            const SizedBox(height: 12),

            const LessonCard(
              iconText: "سلام",
              iconBg: Color(0xFFD9E3F0),
              iconTextColor: Color(0xFF1E4A7B),
              title: "Greetings & Introductions",
              subtitle: "سلام و معرفی",
              statusText: "IN PROGRESS",
              statusBg: Color(0xFFDCEADF),
              statusTextColor: Color(0xFF3E6F50),
              progressText: "3/8 lessons",
              progressFilled: 3,
              progressTotal: 5,
            ),

            const SizedBox(height: 16),

            const LessonCard(
              iconText: "شمار",
              iconBg: Color(0xFFF0E3C8),
              iconTextColor: Color(0xFFC28A1F),
              title: "Numbers & Counting",
              subtitle: "اعداد و شمارش",
              statusText: "COMPLETE",
              statusBg: Color(0xFFDCE5F3),
              statusTextColor: Color(0xFF2D5D99),
              progressText: "8/8 lessons",
              progressFilled: 5,
              progressTotal: 5,
            ),

            const SizedBox(height: 16),

            const LessonCard(
              iconText: "خانه",
              iconBg: Color(0xFFF1E0E0),
              iconTextColor: Color(0xFF9C2F2F),
              title: "Family & Home",
              subtitle: "خانواده و خانه",
              statusText: "START",
              statusBg: Color(0xFFDCEADF),
              statusTextColor: Color(0xFF3E6F50),
              progressText: "0/8 lessons",
              progressFilled: 0,
              progressTotal: 5,
            ),

            const SizedBox(height: 16),

            const LessonCard(
              iconText: "بازار",
              iconBg: Color(0xFFE3EBDD),
              iconTextColor: Color(0xFF79906D),
              title: "Market & Shopping",
              subtitle: "بازار و خریداری",
              statusText: "LOCKED",
              statusBg: Color(0xFFF0E9D8),
              statusTextColor: Color(0xFFB5A57D),
              progressText: "Locked",
              progressFilled: 0,
              progressTotal: 5,
              locked: true,
            ),

            const SizedBox(height: 28),

            const SectionTitle("SCRIPT PRACTICE"),
            const SizedBox(height: 12),

            LessonCard(
              iconText: "الف",
              iconBg: const Color(0xFFD9E3F0),
              iconTextColor: const Color(0xFF1E4A7B),
              title: "Dari Alphabet",
              subtitle: "letters 32 — الفبای دری",
              statusText: "PRACTICE",
              statusBg: const Color(0xFFDCEADF),
              statusTextColor: const Color(0xFF3E6F50),
              progressText: "12/32 mastered",
              progressFilled: 2,
              progressTotal: 5,
              onTap: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(
                    builder: (context) => const AlphabetPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 3,
        color: Color(0xFF8D7953),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String iconText;
  final Color iconBg;
  final Color iconTextColor;

  final String title;
  final String subtitle;

  final String statusText;
  final Color statusBg;
  final Color statusTextColor;

  final String progressText;
  final int progressFilled;
  final int progressTotal;

  final bool locked;

  final VoidCallback? onTap;

  const LessonCard({
    super.key,
    required this.iconText,
    required this.iconBg,
    required this.iconTextColor,
    required this.title,
    required this.subtitle,
    required this.statusText,
    required this.statusBg,
    required this.statusTextColor,
    required this.progressText,
    required this.progressFilled,
    required this.progressTotal,
    this.locked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double opacity = locked ? 0.45 : 1.0;

    return Opacity(
      opacity: opacity,
      child: GestureDetector(
        onTap: locked ? null : onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFDFCF9),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: const Color(0xFFD8D1C6)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(24),
                ),
                alignment: Alignment.center,
                child: Text(
                  iconText,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: iconTextColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: SizedBox(
                  height: 96,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Text(
                                  title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF211A14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  subtitle,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFF8D7953),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                StatusBadge(
                                  text: statusText,
                                  backgroundColor: statusBg,
                                  textColor: statusTextColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ProgressDots(
                            filled: progressFilled,
                            total: progressTotal,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            progressText,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF8D7953),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
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

class StatusBadge extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const StatusBadge({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class ProgressDots extends StatelessWidget {
  final int filled;
  final int total;

  const ProgressDots({
    super.key,
    required this.filled,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (index) {
        final bool isFilled = index < filled;
        return Container(
          margin: const EdgeInsets.only(right: 6),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: isFilled
                ? const Color(0xFF274C77)
                : const Color(0xFFE2D4AA),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
// Alphabet page is a placeholder for the script practice section. It can be expanded with actual content and functionality as needed.
class AlphabetPage extends StatelessWidget {
  const AlphabetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dari Alphabet"),
      ),
      body: const Center(
        child: Text("Alphabet Page"),
      ),
    );
  }
}