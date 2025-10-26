import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../UiHelper/SocialIcon.dart';

class HomeSection extends StatefulWidget {
  const HomeSection({super.key});

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isLargeScreen = screenWidth > 800;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    double cardMaxWidth = isLargeScreen ? 650 : double.infinity;
    EdgeInsetsGeometry cardMargin = isLargeScreen
        ? const EdgeInsets.only(left: 40, right: 20, top: 10)
        : const EdgeInsets.all(16);

    return Align(
      alignment: isLargeScreen ? Alignment.topLeft : Alignment.center,
      child: Container(
        margin: cardMargin,
        constraints: BoxConstraints(maxWidth: cardMaxWidth),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isDark
                ? Colors.deepPurple.shade700
                : Colors.deepPurple.shade100,
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.deepPurple.shade900
                  : Colors.deepPurple.shade200,
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),

        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: SlideTransition(
            position: _slideAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? [const Color(0xFF1F1B24), const Color(0xFF2C2640)]
                        : [const Color(0xFFFFFFFF), const Color(0xFFF1ECFF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 32, vertical: 36),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Profile Picture with glow
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.4),
                              blurRadius: 20,
                              spreadRadius: 4,
                            )
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            'assets/meAvatar.jpg',
                            width: isLargeScreen ? 180 : 140,
                            height: isLargeScreen ? 180 : 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Full Name
                      Text(
                        "Aronno Kumar Ghosh",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 24 : 22,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? Colors.white70
                              : Colors.deepPurple.shade800,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Profession and Degree
                      Text(
                        "Undergraduate Student, CSE at RUET",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 14 : 16,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white60
                              : Colors.deepPurple.shade700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Flutter Developer Tagline
                      Text(
                        "Flutter Developer | \nMobile & Web Applications",
                        style: TextStyle(
                          fontSize: isLargeScreen ? 16 : 14,
                          fontWeight: FontWeight.w500,
                          color: isDark
                              ? Colors.deepPurple.shade100
                              : Colors.deepPurple.shade500,
                          letterSpacing: 0.8,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 18),

                      // Location with Icon
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: isDark
                                ? Colors.deepPurple.shade200
                                : Colors.deepPurple.shade400,
                            size: isLargeScreen ? 20 : 18,
                          ),
                          const SizedBox(width: 6),
                          Flexible(
                            child: Text(
                              "Rajshahi, Bangladesh",
                              style: TextStyle(
                                fontSize: isLargeScreen ? 16 : 14,
                                fontStyle: FontStyle.italic,
                                color: isDark
                                    ? Colors.deepPurple.shade200
                                    : Colors.deepPurple.shade400,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28),

                      // Social Links
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tooltip(
                              message: "Facebook",
                              child: SocialIconButton(
                                icon: FaIcon(FontAwesomeIcons.facebook,
                                    color: Color(0xFF1877F2)),
                                url:
                                'https://web.facebook.com/aronnokumar.bishnu.5/',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Tooltip(
                              message: "LinkedIn",
                              child: IconButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "LinkedIn profile is currently unavailable.",
                                      ),
                                      duration: Duration(seconds: 3),
                                    ),
                                  );
                                },
                                icon: FaIcon(FontAwesomeIcons.linkedin,
                                    color: Color(0xFF0A66C2)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Tooltip(
                              message: "GitHub",
                              child: SocialIconButton(
                                icon: FaIcon(FontAwesomeIcons.github,
                                    color: isDark ? Colors.white : Colors.black),
                                url: 'https://github.com/AK-Bishnu',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Tooltip(
                              message: "Email",
                              child: SocialIconButton(
                                icon: Icon(Icons.mail,
                                    color: Colors.redAccent),
                                url: 'mailto:aronnoghosh049@gmail.com',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Tooltip(
                              message: "WhatsApp",
                              child: SocialIconButton(
                                icon: FaIcon(FontAwesomeIcons.whatsapp,
                                    color: Color(0xFF25D366)),
                                url: 'https://wa.me/8801778025491',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
