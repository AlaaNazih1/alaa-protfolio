import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';

class QuickFactItem extends StatelessWidget {
  const QuickFactItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: colors.primary.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: colors.secondary, size: 22),
        ),
        const SizedBox(width: 18),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.7),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 5),
              SelectableText(
                value,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        if (onTap != null)
          Icon(
            Icons.arrow_outward_rounded,
            color: colors.onSurface.withValues(alpha: 0.5),
            size: 16,
          ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: onTap == null
          ? content
          : InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: content,
              ),
            ),
    );
  }
}
