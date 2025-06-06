import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final programmingLanguages = <String, Widget>{
      'C': Image.asset('assets/C.png', width: 40, height: 40),
      'C++': Image.asset('assets/c++.png', width: 40, height: 40),
      'Java': Image.asset('assets/java.png', width: 40, height: 40),
      'Dart': FaIcon(
        FontAwesomeIcons.dartLang,
        size: 40,
        color: isDark ? Colors.lightBlue.shade300 : Colors.blue,
      ),
    };

    final frameworksAndLibraries = <String, Widget?>{
      'Flutter': FaIcon(
        FontAwesomeIcons.flutter,
        size: 40,
        color: isDark ? Colors.lightBlue.shade300 : Colors.blueAccent,
      ),
      'Java Swing': FaIcon(
        FontAwesomeIcons.java,
        size: 40,
        color: isDark ? Colors.orange.shade300 : Colors.orange,
      ),
      'State Management\n(Provider)': Icon(
        Icons.extension,
        size: 40,
        color: isDark ? Colors.deepPurple.shade300 : Colors.deepPurple,
      ),
      'Local Database\n(SQFlite)': Image.asset('sqlite.png', width: 40, height: 40),
      'REST API': Icon(
        Icons.cloud_queue,
        size: 40,
        color: isDark ? Colors.tealAccent.shade100 : Colors.teal,
      ),
    };


    final cardColorDark = const Color(0x662B006B); // deepPurple.shade900 with opacity 0.4
    final cardColorLight = const Color(0x130E0EFA); // deepPurple with opacity 0.07

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(
            color: isDark
                ? Colors.deepPurple.shade400.withOpacity(0.8)
                : Colors.transparent,
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
                'Skills',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: isDark ? Colors.deepPurple.shade100 : Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              _buildSkillCategory(
                title: 'Programming Languages',
                skills: programmingLanguages,
                isDark: isDark,
              ),
              const SizedBox(height: 32),
              _buildSkillCategory(
                title: 'Frameworks & Libraries',
                skills: frameworksAndLibraries,
                isDark: isDark,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCategory({
    required String title,
    required Map<String, Widget?> skills,
    required bool isDark,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.deepPurple.shade100 : Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 20,
          runSpacing: 20,
          children: skills.entries.map((entry) {
            final iconWidget = entry.value ?? const SizedBox.shrink();

            // Detect long text for width sizing
            final isWideLabel = entry.key.length > 20;
            final chipWidth = isWideLabel ? 130.0 : 100.0;

            return Container(
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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: iconWidget,
                  ),
                  SizedBox(
                    width: chipWidth,
                    child: Text(
                      entry.key,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      maxLines: 3,
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: isDark ? Colors.grey.shade300 : Colors.deepPurple.shade900,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        height: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }


}
