import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({super.key});

  static const String _githubUrl = 'https://github.com/AlaaNazih1';

  static const String _linkedinUrl = 'https://www.linkedin.com/in/alaanazih';

  Future<void> _openUrl(String value) async {
    final uri = Uri.tryParse(value);

    if (uri == null || uri.scheme != 'https' || uri.host.isEmpty) {
      debugPrint('Invalid URL: $value');
      return;
    }

    try {
      final launched = await launchUrl(uri, mode: LaunchMode.platformDefault);

      if (!launched) {
        debugPrint('Could not open URL: $uri');
      }
    } catch (error) {
      debugPrint('Could not open URL: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(top: BorderSide(color: theme.dividerColor, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isMobile = constraints.maxWidth < 500;

              final copyright = Text(
                '© 2026 Alaa Nazih. Flutter Developer. '
                'All rights reserved.',
                style: TextStyle(
                  color: colors.onSurface.withValues(alpha: 0.55),
                  fontSize: 14,
                  height: 1.5,
                ),
              );

              final socialLinks = Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _FooterIconButton(
                    tooltip: 'GitHub',
                    icon: FontAwesomeIcons.github,
                    onTap: () => _openUrl(_githubUrl),
                  ),
                  const SizedBox(width: 12),
                  _FooterIconButton(
                    tooltip: 'LinkedIn',
                    icon: FontAwesomeIcons.linkedin,
                    onTap: () => _openUrl(_linkedinUrl),
                  ),
                ],
              );

              if (isMobile) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    copyright,
                    const SizedBox(height: 18),
                    socialLinks,
                  ],
                );
              }

              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: copyright),
                  const SizedBox(width: 20),
                  socialLinks,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FooterIconButton extends StatefulWidget {
  const _FooterIconButton({
    required this.tooltip,
    required this.icon,
    required this.onTap,
  });

  final String tooltip;
  final FaIconData icon;
  final VoidCallback onTap;

  @override
  State<_FooterIconButton> createState() => _FooterIconButtonState();
}

class _FooterIconButtonState extends State<_FooterIconButton> {
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
          borderRadius: BorderRadius.circular(8),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _isHovered
                  ? colors.surfaceContainerHighest
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: FaIcon(
              widget.icon,
              size: 23,
              color: _isHovered
                  ? colors.secondary
                  : colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
