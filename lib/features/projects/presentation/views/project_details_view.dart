import 'package:alaa_protfolio/features/projects/presentation/widgets/details/project_demo_video.dart';
import 'package:alaa_protfolio/features/projects/presentation/widgets/details/project_details_header.dart';
import 'package:alaa_protfolio/features/projects/presentation/widgets/details/project_gallery.dart';
import 'package:alaa_protfolio/features/projects/presentation/widgets/details/project_overview.dart';
import 'package:alaa_protfolio/features/projects/presentation/widgets/details/project_technologies.dart';
import 'package:flutter/material.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';
import 'package:alaa_protfolio/features/projects/presentation/models/project_model.dart';

class ProjectDetailsView extends StatelessWidget {
  const ProjectDetailsView({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: ProjectDetailsHeader(
                onBack: () => Navigator.of(context).maybePop(),
              ),
            ),

            Divider(height: 1, color: theme.dividerColor),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppSizes.maxWidth,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 32,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProjectHeading(context),
                          const SizedBox(height: 32),

                          ProjectGallery(imagePaths: project.imagePaths),
                          const SizedBox(height: 48),

                          if (project.videoUrl != null &&
                              project.videoUrl!.trim().isNotEmpty) ...[
                            ProjectDemoVideo(videoPath: project.videoUrl!),
                            const SizedBox(height: 48),
                          ],

                          ProjectOverview(project: project),
                          const SizedBox(height: 32),

                          ProjectTechnologies(project: project),
                          const SizedBox(height: 48),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectHeading(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Projects',
          style: TextStyle(color: colors.secondary, fontSize: 16),
        ),
        const SizedBox(height: 16),
        Text(
          project.title,
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
