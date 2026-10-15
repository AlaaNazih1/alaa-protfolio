import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';

class SoftSkillsCard extends StatelessWidget {
  const SoftSkillsCard({super.key});

  static const List<String> _skills = [
    'Problem Solving',
    'Team Work',
    'Communication and Presentation Skills',
    'Time Management',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: colors.secondary.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Icon(
                  Icons.groups_rounded,
                  color: colors.secondary,
                  size: 25,
                ),
              ),
              const SizedBox(width: 14),
              Text(
                'Soft Skills',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Wrap(
            spacing: 36,
            runSpacing: 18,
            children: _skills
                .map(
                  (skill) => Text(
                    skill,
                    style: TextStyle(
                      color: colors.onSurface.withValues(alpha: 0.75),
                      fontSize: 15,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
