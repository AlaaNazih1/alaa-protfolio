import 'package:flutter/material.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';
import 'package:alaa_protfolio/features/experience/presentation/data/experience_data.dart';
import 'package:alaa_protfolio/features/experience/presentation/models/experience_model.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Experience',
                style: TextStyle(color: colors.secondary, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                'Professional Training',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Hands-on training in Flutter development '
                'and modern software practices.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.75),
                  fontSize: 18,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 48),
              ...ExperienceData.experiences.map(
                (experience) => Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: _ExperienceCard(experience: experience),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.experience});

  final ExperienceModel experience;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 600;

        final iconContainer = Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: experience.color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(experience.icon, color: experience.color, size: 30),
        );

        final experienceContent = Container(
          width: double.infinity,
          padding: EdgeInsets.all(isNarrow ? 20 : 28),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, innerConstraints) {
                  final isHeaderNarrow = innerConstraints.maxWidth < 480;

                  final title = Text(
                    experience.title,
                    style: TextStyle(
                      color: colors.onSurface,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  );

                  final date = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 18,
                        color: colors.onSurface.withValues(alpha: 0.55),
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          experience.dateRange,
                          style: TextStyle(
                            color: colors.onSurface.withValues(alpha: 0.75),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  );

                  if (isHeaderNarrow) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [title, const SizedBox(height: 12), date],
                    );
                  }

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: title),
                      const SizedBox(width: 12),
                      Flexible(child: date),
                    ],
                  );
                },
              ),
              const SizedBox(height: 10),
              Text(
                experience.organization,
                style: TextStyle(
                  color: colors.secondary,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                experience.description,
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.75),
                  fontSize: 16,
                  height: 1.7,
                ),
              ),
            ],
          ),
        );

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              iconContainer,
              const SizedBox(height: 16),
              experienceContent,
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconContainer,
            const SizedBox(width: 24),
            Expanded(child: experienceContent),
          ],
        );
      },
    );
  }
}
