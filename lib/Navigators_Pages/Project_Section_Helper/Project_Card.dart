import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Project_Details.dart';
import 'Project_Model.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({
    super.key,
    required this.project,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  void _launchGitHub(BuildContext context) async {
    final url = Uri.parse(widget.project.githubUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open GitHub URL')),
      );
    }
  }

  void _openProjectDetails(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Project Details',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.centerRight,
          child: ProjectDetailPage(project: widget.project),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curvedAnimation =
        CurvedAnimation(parent: animation, curve: Curves.easeInOut);
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(curvedAnimation),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        transform: _isHovered ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: _isHovered
              ? [
            BoxShadow(
              color: isDark
                  ? Colors.deepPurple.shade300.withOpacity(0.6)
                  : Colors.black,
              blurRadius: 20,
              offset: const Offset(0, 12),
            ),
          ]
              : [
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
        ),
        width: 300,
        height: 400,
        padding: const EdgeInsets.all(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => _openProjectDetails(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Image with border
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark
                          ? Colors.deepPurple.shade300.withOpacity(0.6)
                          : Colors.deepPurple.shade200.withOpacity(0.7),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        widget.project.mainImage,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Title with border
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark
                          ? Colors.deepPurple.shade300.withOpacity(0.6)
                          : Colors.deepPurple.shade200.withOpacity(0.7),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    widget.project.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? Colors.deepPurple.shade100
                          : Colors.deepPurple.shade900,
                      height: 1.3,
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Description with border, fixed height and scroll
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isDark
                            ? Colors.deepPurple.shade300.withOpacity(0.5)
                            : Colors.deepPurple.shade200.withOpacity(0.6),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SingleChildScrollView(
                      child: Text(
                        widget.project.shortDescription,
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? Colors.grey.shade300 : Colors.grey.shade800,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // GitHub icon aligned bottom right
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      size: 24,
                      color: isDark ? Colors.deepPurple.shade100 : Colors.deepPurple,
                    ),
                    tooltip: 'View on GitHub',
                    onPressed: () => _launchGitHub(context),
                    splashRadius: 22,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


