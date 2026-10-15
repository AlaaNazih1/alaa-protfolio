import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';
import '../models/project_model.dart';
import '../models/projects_data.dart';
import '../widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key, required this.onProjectTap});

  final ValueChanged<ProjectModel> onProjectTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final featuredProjects = ProjectsData.featuredProjects;
    final otherProjects = ProjectsData.projects
        .where((project) => !project.isFeatured)
        .toList();

    final crossAxisCount = screenWidth >= 1100
        ? 2
        : screenWidth >= AppSizes.mobileBreakpoint
        ? 2
        : 1;

    return Container(
      key: const ValueKey('projects-section'),
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 48,
        vertical: isMobile ? 48 : 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Projects',
                style: TextStyle(
                  color: colors.secondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Featured Work',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: isMobile ? 38 : 54,
                  height: 1.1,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: 720,
                child: Text(
                  'A showcase of my Flutter projects, demonstrating clean '
                  'architecture, scalable solutions, and attention to detail.',
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.75),
                    fontSize: 18,
                    height: 1.7,
                  ),
                ),
              ),
              const SizedBox(height: 52),

              // Featured projects
              ...featuredProjects.map(
                (project) => Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: ProjectCard(
                    project: project,
                    isFeatured: true,
                    onTap: () => onProjectTap(project),
                  ),
                ),
              ),

              // Remaining projects
              LayoutBuilder(
                builder: (context, constraints) {
                  const spacing = 24.0;

                  final cardWidth =
                      (constraints.maxWidth - spacing * (crossAxisCount - 1)) /
                      crossAxisCount;

                  return Wrap(
                    spacing: spacing,
                    runSpacing: spacing,
                    children: otherProjects.map((project) {
                      return SizedBox(
                        width: cardWidth,
                        child: ProjectCard(
                          project: project,
                          onTap: () => onProjectTap(project),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
