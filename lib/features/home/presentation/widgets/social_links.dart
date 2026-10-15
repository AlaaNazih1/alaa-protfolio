import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/constant/app_sizes.dart';

class SocialLinks extends StatelessWidget {
  const SocialLinks({
    super.key,
    required this.githubUrl,
    required this.linkedInUrl,
    required this.email,
  });

  final String githubUrl;
  final String linkedInUrl;
  final String email;

  Future<void> _openUrl(String value) async {
    final uri = Uri.tryParse(value);

    if (uri == null) {
      debugPrint('Invalid URL: $value');
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

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        _SocialButton(
          icon: FontAwesomeIcons.github,
          tooltip: 'GitHub',
          onTap: () => _openUrl(githubUrl),
        ),
        _SocialButton(
          icon: FontAwesomeIcons.linkedinIn,
          tooltip: 'LinkedIn',
          onTap: () => _openUrl(linkedInUrl),
        ),
        _SocialButton(
         icon: FontAwesomeIcons.at,
          tooltip: 'Email',
          onTap: () => _openUrl('mailto:$email'),
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  const _SocialButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final FaIconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(AppSizes.radiusMD),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: _isHovered ? colors.surface : Colors.transparent,
              border: Border.all(
                color: _isHovered ? colors.secondary : theme.dividerColor,
              ),
              borderRadius: BorderRadius.circular(AppSizes.radiusMD),
            ),
            child: Center(
              child: FaIcon(
                widget.icon,
                color: _isHovered ? colors.secondary : colors.onSurface,
                size: 21,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
