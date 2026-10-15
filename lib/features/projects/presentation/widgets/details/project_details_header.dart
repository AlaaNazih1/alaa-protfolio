import 'package:flutter/material.dart';

class ProjectDetailsHeader extends StatelessWidget {
  const ProjectDetailsHeader({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton.icon(
          onPressed: onBack,
          icon: const Icon(Icons.arrow_back),
          label: const Text('All Projects'),
          style: TextButton.styleFrom(
            foregroundColor: colors.onSurface.withValues(alpha: 0.75),
          ),
        ),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: '<',
                style: TextStyle(color: colors.secondary),
              ),
              TextSpan(
                text: 'AN',
                style: TextStyle(color: colors.onSurface),
              ),
              TextSpan(
                text: '/>',
                style: TextStyle(color: colors.secondary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
