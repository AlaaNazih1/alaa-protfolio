import 'package:alaa_protfolio/core/constant/app_sizes.dart';
import 'package:flutter/material.dart';

import '../../../../core/widgets/page_container.dart';
import '../../../../core/utils/responsive.dart';

class HomeNavbar extends StatelessWidget {
  const HomeNavbar({
    super.key,
    required this.activeSection,
    required this.onSectionTap,
    required this.isDarkMode,
    required this.onThemeToggle,
    required this.onLanguageToggle,
  });

  final String activeSection;
  final ValueChanged<String> onSectionTap;
  final bool isDarkMode;
  final VoidCallback onThemeToggle;
  final VoidCallback onLanguageToggle;

  static const List<Map<String, String>> _sections = [
    {'title': 'About', 'key': 'about'},
    {'title': 'Skills', 'key': 'skills'},
    {'title': 'Projects', 'key': 'projects'},
    {'title': 'Experience', 'key': 'experience'},
    {'title': 'Education', 'key': 'education'},
    {'title': 'Contact', 'key': 'contact'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      height: AppSizes.navbarHeight,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: Border(bottom: BorderSide(color: theme.dividerColor, width: 1)),
      ),
      child: PageContainer(
        child: Row(
          children: [
            _buildLogo(context),

            const Spacer(),

            if (!Responsive.isMobile(context))
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: _sections.map((section) {
                    final title = section['title']!;
                    final key = section['key']!;

                    return _NavbarLink(
                      title: title,
                      isActive: activeSection == key,
                      onTap: () => onSectionTap(key),
                    );
                  }).toList(),
                ),
              )
            else
              const Spacer(),

            const Spacer(),

            _NavbarIconButton(
              icon: Icons.language_rounded,
              tooltip: 'Change language',
              onTap: onLanguageToggle,
            ),

            const SizedBox(width: 12),

            _NavbarIconButton(
              icon: isDarkMode
                  ? Icons.light_mode_outlined
                  : Icons.dark_mode_outlined,
              tooltip: 'Change theme',
              onTap: onThemeToggle,
            ),

            if (Responsive.isMobile(context)) ...[
              const SizedBox(width: 8),
              PopupMenuButton<String>(
                tooltip: 'Navigation menu',
                icon: Icon(Icons.menu_rounded, color: colors.onSurface),
                color: colors.surface,
                onSelected: onSectionTap,
                itemBuilder: (context) => _sections.map((section) {
                  return PopupMenuItem<String>(
                    value: section['key']!,
                    child: Text(section['title']!),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => onSectionTap('home'),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text.rich(
          TextSpan(
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
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            letterSpacing: -1,
          ),
        ),
      ),
    );
  }
}

class _NavbarLink extends StatefulWidget {
  const _NavbarLink({
    required this.title,
    required this.isActive,
    required this.onTap,
  });

  final String title;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavbarLink> createState() => _NavbarLinkState();
}

class _NavbarLinkState extends State<_NavbarLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.isActive || _isHovered;
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: TextStyle(
              color: highlighted
                  ? colors.secondary
                  : colors.onSurface.withValues(alpha: 0.75),
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}

class _NavbarIconButton extends StatefulWidget {
  const _NavbarIconButton({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  State<_NavbarIconButton> createState() => _NavbarIconButtonState();
}

class _NavbarIconButtonState extends State<_NavbarIconButton> {
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
          borderRadius: BorderRadius.circular(AppSizes.radiusSM),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _isHovered ? colors.surface : Colors.transparent,
              border: Border.all(color: theme.dividerColor),
              borderRadius: BorderRadius.circular(AppSizes.radiusSM),
            ),
            child: Icon(widget.icon, color: colors.onSurface, size: 22),
          ),
        ),
      ),
    );
  }
}
