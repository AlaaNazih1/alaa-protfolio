import 'package:alaa_protfolio/features/about/presentation/view/about_section.dart';
import 'package:alaa_protfolio/features/contact/presentation/views/contact_section.dart';
import 'package:alaa_protfolio/features/education/presentation/views/education_section.dart';
import 'package:alaa_protfolio/features/experience/presentation/views/experience_section.dart';
import 'package:alaa_protfolio/features/home/presentation/widgets/back_to_top_button.dart';
import 'package:alaa_protfolio/features/home/presentation/widgets/home_footer.dart';
import 'package:alaa_protfolio/features/projects/presentation/models/project_model.dart';
import 'package:alaa_protfolio/features/projects/presentation/views/project_details_view.dart';
import 'package:alaa_protfolio/features/projects/presentation/views/projects_section.dart';
import 'package:alaa_protfolio/features/skills/presentation/views/skills_section.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/hero_section.dart';
import '../widgets/home_navbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
    required this.isDarkMode,
    required this.onThemeToggle,
  });
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  String _activeSection = 'home';
  static const String cvUrl =
      'https://drive.google.com/file/d/1ziCQYNhh65CFY_dnPXhmv2BIOxpGjaqA/view?pli=1';

  Map<String, GlobalKey> get _sectionKeys => {
    'home': _homeKey,
    'about': _aboutKey,
    'skills': _skillsKey,
    'projects': _projectsKey,
    'experience': _experienceKey,
    'education': _educationKey,
    'contact': _contactKey,
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_handleScroll)
      ..dispose();

    super.dispose();
  }

  void _handleScroll() {
    String currentSection = 'home';

    for (final entry in _sectionKeys.entries) {
      final sectionContext = entry.value.currentContext;
      if (sectionContext == null) continue;

      final renderObject = sectionContext.findRenderObject();
      if (renderObject is! RenderBox) continue;

      final position = renderObject.localToGlobal(Offset.zero);

      if (position.dy <= 180) {
        currentSection = entry.key;
      }
    }

    if (currentSection != _activeSection && mounted) {
      setState(() => _activeSection = currentSection);
    }
  }

  void _scrollTo(GlobalKey key) {
    final sectionContext = key.currentContext;
    if (sectionContext == null) return;

    Scrollable.ensureVisible(
      sectionContext,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOutCubic,
      alignment: 0,
    );
  }

  void _onSectionTap(String section) {
    final key = _sectionKeys[section];
    if (key != null) _scrollTo(key);
  }

  void _toggleLanguage() {
    // هنربط تغيير اللغة لما نضيف Localization.
  }

  Future<void> _openUrl(String value) async {
    final uri = Uri.tryParse(value);

    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      debugPrint('Please configure a valid URL: $value');
      return;
    }

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);

      if (!launched) {
        debugPrint('Could not open URL: $uri');
      }
    } catch (error) {
      debugPrint('Error opening URL: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                SizedBox(key: _homeKey, height: 1),

                HeroSection(
                  onContactTap: () => _scrollTo(_contactKey),
                  onViewCvTap: () {
                    if (cvUrl.isNotEmpty) {
                      _openUrl(cvUrl);
                    }
                  },
                ),

                KeyedSubtree(key: _aboutKey, child: const AboutSection()),

                KeyedSubtree(key: _skillsKey, child: const SkillsSection()),

                KeyedSubtree(
                  key: _projectsKey,
                  child: ProjectsSection(
                    onProjectTap: (ProjectModel project) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ProjectDetailsView(project: project),
                        ),
                      );
                    },
                  ),
                ),
                KeyedSubtree(
                  key: _experienceKey,
                  child: const ExperienceSection(),
                ),
                KeyedSubtree(
                  key: _educationKey,
                  child: const EducationSection(),
                ),
                KeyedSubtree(key: _contactKey, child: const ContactSection()),
                const HomeFooter(),
              ],
            ),
          ),

          SafeArea(
            bottom: false,
            child: HomeNavbar(
              activeSection: _activeSection,
              onSectionTap: _onSectionTap,
              isDarkMode: widget.isDarkMode,
              onThemeToggle: widget.onThemeToggle,
              onLanguageToggle: _toggleLanguage,
            ),
          ),
          BackToTopButton(scrollController: _scrollController),
        ],
      ),
    );
  }
}
