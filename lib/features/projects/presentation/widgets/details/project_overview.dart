import 'package:flutter/material.dart';

import 'package:alaa_protfolio/features/projects/presentation/models/project_model.dart';

class ProjectOverview extends StatelessWidget {
  const ProjectOverview({super.key, required this.project});

  final ProjectModel project;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(context, 'Overview'),
        const SizedBox(height: 20),
        Text(
          project.description,
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.75),
            fontSize: 17,
            height: 1.8,
          ),
        ),
        if (project.role != null && project.role!.trim().isNotEmpty) ...[
          const SizedBox(height: 24),
          _buildRole(context),
        ],
        if (project.features.isNotEmpty) ...[
          const SizedBox(height: 32),
          _buildFeatures(context),
        ],
      ],
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      title,
      style: TextStyle(
        color: colors.onSurface,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildRole(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.person_outline, color: colors.secondary, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Role',
                  style: TextStyle(
                    color: colors.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  project.role!,
                  style: TextStyle(
                    color: colors.onSurface.withValues(alpha: 0.75),
                    fontSize: 15,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatures(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Key Features',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 18),
        ...project.features.map(
          (feature) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.check_circle_outline,
                  color: colors.secondary,
                  size: 21,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feature,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.75),
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
