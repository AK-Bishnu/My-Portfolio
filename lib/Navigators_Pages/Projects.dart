import 'package:flutter/material.dart';
import 'Project_Section_Helper/Project_List.dart';
import 'Project_Section_Helper/Project_Card.dart';


class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColorDark = const Color(0x662B006B); // deepPurple.shade900 with opacity 0.4
    final cardColorLight = const Color(0x130E0EFA); // deepPurple with opacity 0.07

    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
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
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Projects',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),

              // Horizontal Scrollable Cards
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(projects.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProjectCard(
                        project: projects[index],
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 24),

            ],
          ),
        ),
      ),
    );
  }
}
