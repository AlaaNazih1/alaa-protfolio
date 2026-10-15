import 'package:flutter/material.dart';

import '../../../../core/constant/app_colors.dart';
import '../../../../core/constant/app_sizes.dart';

class AvailabilityBadge extends StatelessWidget {
  const AvailabilityBadge({
    super.key,
    this.label = 'Available for opportunities',
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.75),
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 9,
            height: 9,
            decoration: const BoxDecoration(
              color: AppColors.success,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSizes.spaceSM),
          Text(
            label,
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.8),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
