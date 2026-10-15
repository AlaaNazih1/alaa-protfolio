import 'package:flutter/material.dart';

class ContactInfoCard extends StatelessWidget {
  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.dividerColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: colors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: colors.secondary, size: 25),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
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
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              if (onTap != null) ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_outward_rounded,
                  size: 18,
                  color: colors.onSurface.withValues(alpha: 0.45),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
