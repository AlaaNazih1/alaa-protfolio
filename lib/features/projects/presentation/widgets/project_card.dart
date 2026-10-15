import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/app_sizes.dart';
import '../models/project_model.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    this.isFeatured = false,
  });

  final ProjectModel project;
  final VoidCallback onTap;
  final bool isFeatured;

  Future<void> _openGithub() async {
    final githubUrl = project.githubUrl.trim();
    final uri = Uri.tryParse(githubUrl);

    if (uri == null ||
        uri.scheme != 'https' ||
        uri.host != 'github.com' ||
        uri.pathSegments.length < 2 ||
        uri.pathSegments.any(
          (segment) => segment.isEmpty || segment.contains('YOUR_'),
        )) {
      debugPrint('Invalid GitHub URL: "$githubUrl"');
      return;
    }

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);

      if (!launched) {
        debugPrint('Could not open GitHub: $uri');
      }
    } catch (error) {
      debugPrint('Error opening GitHub: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppSizes.radiusLG),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ProjectPreview(
              project: project,
              isFeatured: isFeatured || project.isFeatured,
            ),
            Padding(
              padding: EdgeInsets.all(isFeatured ? 28 : 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: isFeatured ? 26 : 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    project.description,
                    maxLines: isFeatured ? 4 : 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.75),
                      fontSize: 15,
                      height: 1.8,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: project.technologies
                        .map((technology) => _TechnologyTag(label: technology))
                        .toList(),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: _openGithub,
                      icon: const FaIcon(FontAwesomeIcons.github, size: 18),
                      label: const Text('View on GitHub'),
                      style: FilledButton.styleFrom(
                        backgroundColor: colors.primary,
                        foregroundColor: colors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 17),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppSizes.radiusMD,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProjectPreview extends StatelessWidget {
  const _ProjectPreview({required this.project, required this.isFeatured});

  final ProjectModel project;
  final bool isFeatured;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final imagePath = project.imagePaths.isNotEmpty
        ? project.imagePaths.first
        : null;

    return SizedBox(
      width: double.infinity,
      height: isFeatured ? 280 : 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: colors.surfaceContainerHighest,
            child: imagePath == null
                ? Icon(
                    Icons.image_outlined,
                    color: colors.onSurface.withValues(alpha: 0.5),
                    size: 54,
                  )
                : Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          color: colors.onSurface.withValues(alpha: 0.5),
                          size: 54,
                        ),
                      );
                    },
                  ),
          ),
          if (isFeatured)
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: colors.primary.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, color: colors.secondary, size: 15),
                    const SizedBox(width: 6),
                    Text(
                      'Featured',
                      style: TextStyle(
                        color: colors.secondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _TechnologyTag extends StatelessWidget {
  const _TechnologyTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.dark
            ? colors.surfaceContainerHighest
            : colors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: colors.onSurface.withValues(alpha: 0.8),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
