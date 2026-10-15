import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:alaa_protfolio/features/contact/presentation/widgets/contact_info_card.dart';

class ContactInfo extends StatelessWidget {
  const ContactInfo({super.key});

  static const String email = 'nzyhla227@gmail.com';
  static const String phone = '01009403328';
  static const String location = 'Bani Suef, Egypt';

  static const String githubUrl = 'https://github.com/AlaaNazih1';
  static const String linkedInUrl = 'https://www.linkedin.com/in/alaanazih';
  static const String cvUrl =
      'https://drive.google.com/file/d/1ziCQYNhh65CFY_dnPXhmv2BIOxpGjaqA/view?pli=1';

  Future<void> _openUrl(String value) async {
    final uri = Uri.tryParse(value);

    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      debugPrint('Please configure a valid URL: $value');
      return;
    }

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);

      if (!launched) {
        debugPrint('Could not open URL: $uri');
      }
    } catch (error) {
      debugPrint('Error opening URL: $error');
    }
  }

  Future<void> _sendEmail() async {
    final uri = Uri(scheme: 'mailto', path: email);

    try {
      final launched = await launchUrl(uri);

      if (!launched) {
        debugPrint('Could not open email application.');
      }
    } catch (error) {
      debugPrint('Error opening email: $error');
    }
  }

  Future<void> _callPhone() async {
    final uri = Uri(scheme: 'tel', path: phone);

    try {
      final launched = await launchUrl(uri);

      if (!launched) {
        debugPrint('Could not open phone application.');
      }
    } catch (error) {
      debugPrint('Error opening phone application: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Information',
          style: TextStyle(
            color: colors.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "Feel free to reach out through any of these channels. "
          "I'm always excited to discuss new projects and opportunities.",
          style: TextStyle(
            color: colors.onSurface.withValues(alpha: 0.75),
            fontSize: 16,
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),

        ContactInfoCard(
          icon: Icons.mail_outline_rounded,
          title: 'Email',
          value: email,
          onTap: _sendEmail,
        ),
        const SizedBox(height: 16),

        ContactInfoCard(
          icon: Icons.phone_outlined,
          title: 'Phone',
          value: phone,
          onTap: _callPhone,
        ),
        const SizedBox(height: 16),

        const ContactInfoCard(
          icon: Icons.location_on_outlined,
          title: 'Location',
          value: location,
        ),
        const SizedBox(height: 32),

        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _SocialButton(
              icon: FontAwesomeIcons.github,
              label: 'GitHub',
              onPressed: () => _openUrl(githubUrl),
            ),
            _SocialButton(
              icon: FontAwesomeIcons.linkedinIn,
              label: 'LinkedIn',
              onPressed: () => _openUrl(linkedInUrl),
            ),
            _SocialButton(
              icon: FontAwesomeIcons.file,
              label: 'View CV',
              onPressed: cvUrl.isEmpty ? null : () => _openUrl(cvUrl),
            ),
          ],
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final FaIconData icon;
  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final isEnabled = onPressed != null;

    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: FaIcon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: isEnabled
            ? colors.onSurface
            : colors.onSurface.withValues(alpha: 0.4),
        backgroundColor: colors.surface,
        side: BorderSide(color: theme.dividerColor),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
