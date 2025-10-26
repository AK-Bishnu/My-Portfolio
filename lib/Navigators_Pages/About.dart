import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColorDark = const Color(0x662B006B);
    final cardColorLight = const Color(0x130E0EFA); // deepPurple with opacity ~0.07

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide( // <-- Add border here
            color: isDark
                ? Colors.deepPurple.shade400.withOpacity(0.8) // stronger visible border in dark mode
                : Colors.transparent, // no border in light mode
            width: 1.5,
          ),
        ),
        color: isDark ? cardColorDark : cardColorLight,
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Me',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isDark ? Colors.deepPurple.shade100 : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ..._buildInfoParagraphs(context, isDark),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildInfoParagraphs(BuildContext context, bool isDark) {
    final texts = [
      "Hello! I'm Aronno Kumar Ghosh, a Computer Science and Engineering undergraduate at Rajshahi University of Engineering and Technology. I have a deep enthusiasm for technology and its power to bring ideas into reality.",
      "I specialize in Flutter development, focusing on building sleek, high-performing apps for both mobile and web. My experience includes Flutter widgets, state management (Provider), RESTful APIs, Firebase integration, and local data storage using SQLite.",
      "My journey started in my first semester, where I sharpened my logical skills through competitive programming. Later, I was introduced to OOP concepts through C++ and Java Swing, which sparked my interest in app development. Since then, Flutter has become my go-to framework.",
      "I’m a quick learner and team player with a strong desire to contribute to meaningful projects. Whether it’s crafting intuitive UIs or integrating powerful backends, I'm ready to take on new challenges and grow further as a developer.",
    ];

    return texts
        .map(
          (text) => Padding(
        padding: const EdgeInsets.only(bottom: 22.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: isDark
                ? const LinearGradient(
              colors: [
                Color(0xFF3A3F55),
                Color(0xFF2C3145),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : LinearGradient(
              colors: [
                Colors.purple.shade50,
                Colors.purple.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: isDark
                    ? Colors.black.withOpacity(0.7)
                    : Colors.deepPurple.shade100.withOpacity(0.8),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
              BoxShadow(
                color: isDark
                    ? Colors.blueGrey.shade900.withOpacity(0.5)
                    : Colors.purple.shade200.withOpacity(0.5),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isDark
                  ? Colors.deepPurple.shade700.withOpacity(0.8)
                  : Colors.deepPurple.shade200,
              width: 1.3,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.7,
                fontSize: 16,
                color: isDark ? Colors.grey.shade300 : Colors.deepPurple.shade900,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    )
        .toList();
  }
}
