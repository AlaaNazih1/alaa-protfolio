import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';
import 'package:alaa_protfolio/features/projects/presentation/models/project_model.dart';

class ProjectTechnologies extends StatelessWidget {
  const ProjectTechnologies({super.key, required this.project});

  final ProjectModel project;

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

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: 20),
          _buildTechnologyList(context),
          const SizedBox(height: 28),
          _buildGithubButton(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      children: [
        Icon(Icons.code_rounded, color: colors.secondary, size: 24),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'Technologies & Links',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 21,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTechnologyList(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    if (project.technologies.isEmpty) {
      return Text(
        'No technologies added yet.',
        style: TextStyle(
          color: colors.onSurface.withValues(alpha: 0.55),
          fontSize: 14,
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: project.technologies
          .map((technology) => _buildTechnologyChip(context, technology))
          .toList(),
    );
  }

  Widget _buildTechnologyChip(BuildContext context, String technology) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final chipBackground = theme.brightness == Brightness.dark
        ? colors.surfaceContainerHighest
        : colors.surfaceContainerLow;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: chipBackground,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Text(
        technology,
        style: TextStyle(
          color: colors.onSurface.withValues(alpha: 0.85),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildGithubButton(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: _openGithub,
        icon: const Icon(Icons.open_in_new_rounded),
        label: const Text('View on GitHub'),
        style: FilledButton.styleFrom(
          backgroundColor: colors.primary,
          foregroundColor: colors.onPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
