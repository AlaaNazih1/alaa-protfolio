import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';
import '../../../../core/utils/responsive.dart';
import 'hero_content.dart';
import 'profile_visual.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onViewCvTap,
  });

  final VoidCallback onContactTap;
  final VoidCallback onViewCvTap;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 38 : 45,
        vertical: isMobile ? 95 : 100,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroContent(onContactTap: onContactTap, onViewCvTap: onViewCvTap),
        const SizedBox(height: 40),
        const ProfileVisual(imagePath: 'assets/images/alaa_prtoflio.png'),
      ],
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: HeroContent(
            onContactTap: onContactTap,
            onViewCvTap: onViewCvTap,
          ),
        ),
        const SizedBox(width: 32),
        const Expanded(
          flex: 5,
          child: ProfileVisual(imagePath: 'assets/images/alaa_prtoflio.png'),
        ),
      ],
    );
  }
}
