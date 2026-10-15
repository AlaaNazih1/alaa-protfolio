import 'package:flutter/material.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

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
                'Education',
                style: TextStyle(color: colors.secondary, fontSize: 16),
              ),
              const SizedBox(height: 20),
              Text(
                'Academic Background',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 48),
              LayoutBuilder(
                builder: (context, constraints) {
                  final isMobile = constraints.maxWidth < 700;

                  if (isMobile) {
                    return const Column(
                      children: [
                        _DegreeCard(),
                        SizedBox(height: 20),
                        _TrainingCard(),
                      ],
                    );
                  }

                  return const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: _DegreeCard()),
                      SizedBox(width: 24),
                      Expanded(child: _TrainingCard()),
                    ],
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

class _DegreeCard extends StatelessWidget {
  const _DegreeCard();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return _EducationCard(
      icon: Icons.school_outlined,
      iconColor: const Color(0xFF3B9EFF),
      title: "Bachelor's Degree",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Beni-Suef National University',
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.85),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'B.Sc. in Computer Science',
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.75),
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Faculty of Science · Computer Science Department',
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.6),
              fontSize: 14,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          const _InfoBadge(
            icon: Icons.calendar_today_outlined,
            label: 'Sep 2023 – Sep 2027 (Expected)',
          ),
          const SizedBox(height: 12),
          const _InfoBadge(
            icon: Icons.timelapse_outlined,
            label: 'Currently Pursuing',
            highlight: true,
          ),
          const SizedBox(height: 20),
          Text(
            'Relevant Coursework',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          const Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _CourseChip(label: 'Programming'),
              _CourseChip(label: 'Software Engineering'),
              _CourseChip(label: 'Data Structures & Algorithms'),
              _CourseChip(label: 'Mobile App Development'),
              _CourseChip(label: 'Database Systems'),
              _CourseChip(label: 'Web Development'),
              _CourseChip(label: 'Artificial Intelligence'),
              _CourseChip(label: 'Computer Networks'),
              _CourseChip(label: 'Operating Systems'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrainingCard extends StatelessWidget {
  const _TrainingCard();

  @override
  Widget build(BuildContext context) {
    return _EducationCard(
      icon: Icons.workspace_premium_outlined,
      iconColor: const Color(0xFF34D399),
      title: 'Professional Training',
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _TrainingItem(
            title: 'Flutter Development Program',
            organization: 'National Telecommunication Institute (NTI)',
            period: 'Nov 2025 – Feb 2026',
          ),
          SizedBox(height: 20),
          _TrainingItem(
            title: 'Digital Egypt Pioneers Initiative',
            organization: 'DEPI · Cross-Platform Mobile Development',
            period: 'Nov 2025 – Jul 2026',
          ),
          SizedBox(height: 20),
          _TrainingItem(
            title: 'Flutter Bootcamp',
            organization: 'HumaVolve',
            period: 'Completed · Aug 2026',
          ),
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  const _EducationCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.child,
  });

  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 350;

              final iconWidget = Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: iconColor, size: 32),
              );

              final titleWidget = Text(
                title,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              );

              if (isNarrow) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    iconWidget,
                    const SizedBox(height: 16),
                    titleWidget,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconWidget,
                  const SizedBox(width: 20),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: titleWidget,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 24),
          child,
        ],
      ),
    );
  }
}

class _TrainingItem extends StatelessWidget {
  const _TrainingItem({
    required this.title,
    required this.organization,
    required this.period,
  });

  final String title;
  final String organization;
  final String period;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.menu_book_outlined,
          color: colors.onSurface.withValues(alpha: 0.55),
          size: 19,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.9),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                organization,
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.65),
                  fontSize: 14,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                period,
                style: TextStyle(color: colors.secondary, fontSize: 13),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InfoBadge extends StatelessWidget {
  const _InfoBadge({
    required this.icon,
    required this.label,
    this.highlight = false,
  });

  final IconData icon;
  final String label;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final backgroundColor = highlight
        ? colors.primary.withValues(alpha: 0.12)
        : theme.brightness == Brightness.dark
        ? colors.surfaceContainerHighest
        : colors.surfaceContainerLow;

    final foregroundColor = highlight
        ? colors.secondary
        : colors.onSurface.withValues(alpha: 0.75);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: highlight
              ? colors.primary.withValues(alpha: 0.2)
              : theme.dividerColor,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: foregroundColor),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              label,
              style: TextStyle(color: foregroundColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _CourseChip extends StatefulWidget {
  const _CourseChip({required this.label});

  final String label;

  @override
  State<_CourseChip> createState() => _CourseChipState();
}

class _CourseChipState extends State<_CourseChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
        decoration: BoxDecoration(
          color: _isHovered
              ? colors.primary.withValues(alpha: 0.12)
              : theme.brightness == Brightness.dark
              ? colors.surfaceContainerHighest
              : colors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isHovered ? colors.secondary : theme.dividerColor,
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: colors.primary.withValues(alpha: 0.12),
                    blurRadius: 12,
                    spreadRadius: 1,
                  ),
                ]
              : [],
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          style: TextStyle(
            color: _isHovered
                ? colors.secondary
                : colors.onSurface.withValues(alpha: 0.8),
            fontSize: 12,
            fontWeight: _isHovered ? FontWeight.w600 : FontWeight.normal,
          ),
          child: Text(widget.label),
        ),
      ),
    );
  }
}
