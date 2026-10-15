import 'package:alaa_protfolio/features/home/presentation/widgets/typing_text.dart';
import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';
import 'availability_badge.dart';
import 'social_links.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({
    super.key,
    required this.onContactTap,
    required this.onViewCvTap,
  });

  final VoidCallback onContactTap;
  final VoidCallback onViewCvTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = screenWidth < AppSizes.mobileBreakpoint;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const AvailabilityBadge(),
        const SizedBox(height: 28),

        Text(
          'Alaa Nazih',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: isMobile ? 36 : 48,
            fontWeight: FontWeight.w600,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 12),

        const TypingText(
          text: 'Flutter Developer',
          fontSize: 28,
          typingSpeed: Duration(milliseconds: 140),
          deletingSpeed: Duration(milliseconds: 120),
          pauseDuration: Duration(milliseconds: 2500),
        ),

        const SizedBox(height: 24),

        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 560),
          child: Text(
            'I build modern, responsive mobile applications '
            'with Flutter, focusing on clean code, smooth '
            'user experiences, and scalable solutions.',
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.75),
              fontSize: isMobile ? 15 : 17,
              height: 1.8,
            ),
          ),
        ),

        const SizedBox(height: 32),

        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            FilledButton(
              onPressed: onContactTap,
              style: FilledButton.styleFrom(
                backgroundColor: colors.primary,
                foregroundColor: colors.onPrimary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Get In Touch'),
                  SizedBox(width: 10),
                  Icon(Icons.arrow_forward_rounded, size: 18),
                ],
              ),
            ),

            OutlinedButton(
              onPressed: onViewCvTap,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.onSurface,
                side: BorderSide(color: theme.dividerColor),
                padding: const EdgeInsets.symmetric(
                  horizontal: 26,
                  vertical: 18,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMD),
                ),
              ),
              child: const Text('View CV'),
            ),
          ],
        ),

        const SizedBox(height: 32),

        SocialLinks(
          githubUrl: 'https://github.com/AlaaNazih1',
          linkedInUrl: 'https://www.linkedin.com/in/alaanazih',
          email: 'nzyhla227@gmail.com',
        ),
      ],
    );
  }
}
