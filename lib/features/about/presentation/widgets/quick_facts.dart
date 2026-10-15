import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/app_sizes.dart';
import 'quick_fact_item.dart';

class QuickFacts extends StatelessWidget {
  const QuickFacts({super.key});

  static const String location = 'Bani Suef, Egypt';
  static const String email = 'nzyhla227@gmail.com';
  static const String phone = '+20 1009403328';

  Future<void> _openLink(String value) async {
    final uri = Uri.tryParse(value);

    if (uri == null) {
      debugPrint('Invalid link: $value');
      return;
    }

    try {
      final launched = await launchUrl(uri);

      if (!launched) {
        debugPrint('Could not open link: $uri');
      }
    } catch (error) {
      debugPrint('Could not open link: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Quick Facts',
            style: TextStyle(
              color: colors.onSurface,
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 28),

          const QuickFactItem(
            icon: Icons.location_on,
            label: 'Location',
            value: location,
          ),

          QuickFactItem(
            icon: Icons.email,
            label: 'Email',
            value: email,
            onTap: () => _openLink('mailto:$email'),
          ),

          QuickFactItem(
            icon: Icons.phone,
            label: 'Phone',
            value: phone,
            onTap: () => _openLink('tel:${phone.replaceAll(' ', '')}'),
          ),
        ],
      ),
    );
  }
}
