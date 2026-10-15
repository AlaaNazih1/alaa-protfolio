import 'package:alaa_protfolio/features/about/presentation/widgets/quick_facts.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      key: const ValueKey('about-section'),
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
                'About Me',
                style: TextStyle(
                  color: colors.secondary,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Crafting Solutions,\nNot Just Code',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: isMobile ? 38 : 54,
                  height: 1.05,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1.5,
                ),
              ),
              const SizedBox(height: 48),
              isMobile
                  ? Column(
                      children: const [
                        _AboutContent(),
                        SizedBox(height: 32),
                        QuickFacts(),
                      ],
                    )
                  : const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 5, child: _AboutContent()),
                        SizedBox(width: 48),
                        Expanded(flex: 5, child: QuickFacts()),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _paragraph(
          context,
          "I'm a Flutter Developer with a passion for building mobile "
          'applications that are not only visually appealing but also '
          'architecturally sound and performant.',
        ),
        const SizedBox(height: 28),
        _paragraph(
          context,
          'My approach to development is analytical and solution-oriented. '
          'Before writing a single line of code, I design the architecture '
          'and plan the implementation to ensure scalability and maintainability.',
        ),
        const SizedBox(height: 28),
        _paragraph(
          context,
          'I specialize in Flutter and Firebase, creating cross-platform '
          'applications with clean architecture patterns that stand the test '
          'of time and changing requirements.',
        ),
        const SizedBox(height: 40),
        const _AboutFeatureCards(),
      ],
    );
  }

  Widget _paragraph(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.75),
        fontSize: 18,
        height: 1.9,
      ),
    );
  }
}

class _AboutFeatureCards extends StatelessWidget {
  const _AboutFeatureCards();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 16,
      runSpacing: 16,
      children: [
        _FeatureCard(
          icon: Icons.layers_outlined,
          title: 'Clean Architecture',
          subtitle: 'Scalable & maintainable code',
        ),
        _FeatureCard(
          icon: Icons.storage_outlined,
          title: 'Firebase',
          subtitle: 'Auth, Firestore, Storage',
        ),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: 260,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(AppSizes.radiusMD),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.secondary, size: 28),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.75),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
