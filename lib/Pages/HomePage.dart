import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_portfolio/Navigators_Pages/About.dart';
import 'package:my_portfolio/Navigators_Pages/Contact.dart';
import 'package:my_portfolio/Navigators_Pages/Home.dart';
import 'package:my_portfolio/Navigators_Pages/Projects.dart';
import 'package:my_portfolio/Navigators_Pages/Skills.dart';

class PortfolioHomePage extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleTheme;

  const PortfolioHomePage({
    super.key,
    required this.isDarkMode,
    required this.toggleTheme,
  });

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  final ScrollController _scrollController = ScrollController();
  final ScrollController leftScrollController = ScrollController();

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Sync animation with passed theme state
    if (widget.isDarkMode) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant PortfolioHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update animation when theme toggled externally
    if (widget.isDarkMode != oldWidget.isDarkMode) {
      if (widget.isDarkMode) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    leftScrollController.dispose();
    super.dispose();
  }

  void scrollTo(GlobalKey key) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = key.currentContext;
      if (ctx != null) {
        final totalWidth = MediaQuery.of(context).size.width;
        final isDesktop = totalWidth >= 800;

        ScrollController controller;
        RenderBox box = ctx.findRenderObject() as RenderBox;
        Offset offset;

        if (isDesktop) {
          if (key == homeKey) {
            controller = leftScrollController;
            offset = box.localToGlobal(
              Offset.zero,
              ancestor:
                  leftScrollController.position.context.storageContext
                      .findRenderObject(),
            );
          } else {
            controller = _scrollController;
            offset = box.localToGlobal(
              Offset.zero,
              ancestor:
                  _scrollController.position.context.storageContext
                      .findRenderObject(),
            );
          }
        } else {
          controller = _scrollController;
          offset = box.localToGlobal(
            Offset.zero,
            ancestor:
                _scrollController.position.context.storageContext
                    .findRenderObject(),
          );
        }

        final scrollOffset = controller.offset + offset.dy - kToolbarHeight;

        controller.animateTo(
          scrollOffset,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final isDesktop = totalWidth >= 800;

    final theme = Theme.of(context);
    final backgroundColor = widget.isDarkMode ? Colors.black : Colors.white;

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    //for bright
    const lightGradient = LinearGradient(
      colors: [
        Color(0xFF667EEA), // Softer blue
        Color(0xFF764BA2), // Purple
        Color(0xFFFF7E5F), // Coral accent
      ],
      stops: [0.0, 0.5, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    //for dark
    const darkGradient = LinearGradient(
      colors: [
        Color(0xFF0F2027), // Dark teal
        Color(0xFF203A43), // Deep blue
        Color(0xFF2C5364), // Lighter blue
      ],
      stops: [0.0, 0.5, 1.0],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );


    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 6,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient:  isDarkMode ? darkGradient : lightGradient,

          ),
        ),
        leading: Tooltip(
          message: Theme.of(context).brightness == Brightness.dark
              ? "Switch to Light Mode"
              : "Switch to Dark Mode",
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: widget.toggleTheme,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Center(
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // Light mode icon
                          Opacity(
                            opacity: 1.0 - _animation.value,
                            child: Transform.rotate(
                              angle: (1.0 - _animation.value) * pi,
                              child: Transform.scale(
                                scale: 1.0 - 0.2 * _animation.value,
                                child: Icon(
                                  Icons.wb_sunny_rounded,
                                  size: 28,
                                  color: Colors.yellowAccent.shade200,
                                  shadows: const [
                                    Shadow(
                                      color: Colors.orange,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // Dark mode icon
                          Opacity(
                            opacity: _animation.value,
                            child: Transform.rotate(
                              angle: sin(_animation.value * pi) * pi,
                              child: Transform.scale(
                                scale: 0.8 + 0.2 * _animation.value,
                                child: Icon(
                                  Icons.nights_stay_outlined,
                                  size: 28,
                                  color: Colors.cyanAccent.shade100,
                                  shadows: const [
                                    Shadow(
                                      color: Colors.black87,
                                      blurRadius: 6,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
        leadingWidth: 60,
        actions: isDesktop
            ? buildNavButtons(context)
            : [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
        ],
      ),
      drawer:
          isDesktop
              ? null
              :Drawer(
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: BoxDecoration(
                      gradient: isDarkMode
                          ? const LinearGradient(
                        colors: [Color(0xFF1f1c2c), Color(0xFF928DAB)], // Dark mode
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                          : const LinearGradient(
                        colors: [
                          Color(0xFF00B4DB), // Bright Cyan
                          Color(0xFF0083B0), // Deep Blue
                          Color(0xFF6A11CB), // Rich Purple
                        ],// Bright mode (matches AppBar)
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage('meAvatar.jpg'),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Aronno Kumar Ghosh',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  drawerItem('🏠 Home', homeKey),
                  drawerItem('👨‍💼 About', aboutKey),
                  drawerItem('🛠 Skills', skillsKey),
                  drawerItem('📁 Projects', projectsKey),
                  drawerItem('📞 Contact', contactKey),

                  const SizedBox(height: 12),
                  const Divider(thickness: 0.7, indent: 16, endIndent: 16),
                ],
              ),
            ),
          ),
      body:
          isDesktop
              ? Row(
                children: [
                  Container(
                    width: totalWidth * 0.25,
                    child: SingleChildScrollView(
                      controller: leftScrollController,
                      child: SizedBox(
                        width: double.infinity,
                        child: HomeSection(key: homeKey),
                      ),
                    ),
                  ),
                  Container(
                    width: totalWidth * 0.75,
                    child: SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: AboutSection(key: aboutKey),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: SkillsSection(key: skillsKey),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ProjectsSection(key: projectsKey),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ContactSection(key: contactKey),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: HomeSection(key: homeKey),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: AboutSection(key: aboutKey),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: SkillsSection(key: skillsKey),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ProjectsSection(key: projectsKey),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ContactSection(key: contactKey),
                    ),
                  ],
                ),
              ),
    );
  }

  List<Widget> buildNavButtons(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final List<Map<String, dynamic>> navItems = [
      {'label': '👨‍💼 About', 'key': aboutKey},
      {'label': '🛠 Skills', 'key': skillsKey},
      {'label': '📁 Projects', 'key': projectsKey},
      {'label': '📞 Contact', 'key': contactKey},
    ];

    return navItems
        .map(
          (item) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: animatedNavButton(
          item['label'],
          item['key'],
          isDark,
        ),
      ),
    )
        .toList();
  }
  Widget animatedNavButton(String label, GlobalKey sectionKey, bool isDark) {
    final hoverNotifier = ValueNotifier<bool>(false);

    return MouseRegion(
      onEnter: (_) => hoverNotifier.value = true,
      onExit: (_) => hoverNotifier.value = false,
      child: ValueListenableBuilder<bool>(
        valueListenable: hoverNotifier,
        builder: (context, isHovering, _) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: isHovering
                ? const EdgeInsets.symmetric(horizontal: 2, vertical: 2)
                : EdgeInsets.zero,
            decoration: BoxDecoration(
              color: isHovering
                  ? (isDark ? Colors.white10 : Colors.black12)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Transform.scale(
              scale: isHovering ? 1.03 : 1.0,
              child: TextButton(
                onPressed: () {
                  Scrollable.ensureVisible(
                    sectionKey.currentContext!,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  textStyle: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  overlayColor:Colors.white.withOpacity(0.15),
              ),
                child: Text(label),
              ),
            ),
          );
        },
      ),
    );
  }



  Widget navButton(String label, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        onPressed: () => scrollTo(key),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          textStyle: const TextStyle(
            fontSize: 14.5,
            fontWeight: FontWeight.w600,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          overlayColor: WidgetStateColor.resolveWith(
                (states) => Colors.white.withOpacity(0.15),
          ),
        ),
        child: Text(label),
      ),
    );
  }


  Widget drawerItem(String title, GlobalKey sectionKey) {
    bool isHovered = false;

    return StatefulBuilder(
      builder: (context, setState) {
        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: InkWell(
            onTap: () {
              Scrollable.ensureVisible(
                sectionKey.currentContext!,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                alignment: 0.1,
              );
              Navigator.of(context).pop(); // close drawer
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14),
              decoration: BoxDecoration(
                color: isHovered
                    ? (Theme.of(context).brightness == Brightness.dark
                    ? Colors.white10
                    : Colors.black12)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: isHovered
                    ? Border.all(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white30
                      : Colors.black26,
                  width: 1.2,
                )
                    : null,
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black87,
                ),
              ),
            ),
          ),
        );
      },
    );
  }


}
