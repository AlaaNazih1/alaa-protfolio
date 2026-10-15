import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constant/app_sizes.dart';
import '../widgets/skill_category_card.dart';
import '../widgets/soft_skills_card.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = width < AppSizes.mobileBreakpoint;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final crossAxisCount = width >= 1100
        ? 3
        : width >= AppSizes.mobileBreakpoint
        ? 2
        : 1;

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 48,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Skills',
                style: TextStyle(
                  color: colors.secondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Technical Expertise',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: isMobile ? 36 : 54,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 14),
              Text(
                'Technologies and tools I use to build exceptional '
                'mobile applications.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.75),
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 52),
              LayoutBuilder(
                builder: (context, constraints) {
                  const spacing = 22.0;

                  final cardWidth =
                      (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                      crossAxisCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: 22,
                    children: [
                      SizedBox(
                        width: cardWidth,
                        child: const SkillCategoryCard(
                          title: 'Programming Languages',
                          icon: FontAwesomeIcons.code,
                          accentColor: Color(0xFFB65CFF),
                          skills: ['Dart', 'C++', 'Python'],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const SkillCategoryCard(
                          title: 'Core Concepts',
                          icon: FontAwesomeIcons.brain,
                          accentColor: Color(0xFF369BFF),
                          skills: [
                            'Object-Oriented Programming (OOP)',
                            'Data Structures',
                            'Algorithms',
                            'Design Patterns',
                          ],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const SkillCategoryCard(
                          title: 'Mobile Development',
                          icon: FontAwesomeIcons.mobileScreenButton,
                          accentColor: Color(0xFF31C5D2),
                          skills: [
                            'Flutter',
                            'Responsive UI Design',
                            'State Management (Provider, Cubit, Bloc, Riverpod, GetX)',
                          ],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const SkillCategoryCard(
                          title: 'Databases & Storage',
                          icon: FontAwesomeIcons.database,
                          accentColor: Color(0xFF38D9A9),
                          skills: [
                            'Sqflite (Local Storage)',
                            'Firebase (Authentication)',
                            'Firebase Firestore (Cloud Database)',
                            'Firebase Storage (Cloud Storage)',
                          ],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const SkillCategoryCard(
                          title: 'Backend & APIs',
                          icon: FontAwesomeIcons.server,
                          accentColor: Color(0xFFFF963D),
                          skills: ['RESTful API Integration'],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const SkillCategoryCard(
                          title: 'Software Architecture & Practices',
                          icon: FontAwesomeIcons.layerGroup,
                          accentColor: Color(0xFFED4C9B),
                          skills: ['Clean Code Principles', 'SOLID Principles'],
                        ),
                      ),
                      SizedBox(
                        width: cardWidth,
                        child: const SkillCategoryCard(
                          title: 'Version Control & Collaboration',
                          icon: FontAwesomeIcons.codeBranch,
                          accentColor: Color(0xFF639BFF),
                          skills: ['Git', 'GitHub'],
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 48),
              const SoftSkillsCard(),
            ],
          ),
        ),
      ),
    );
  }
}
