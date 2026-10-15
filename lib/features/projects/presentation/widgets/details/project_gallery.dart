import 'package:flutter/material.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';

class ProjectGallery extends StatefulWidget {
  const ProjectGallery({super.key, required this.imagePaths});

  final List<String> imagePaths;

  @override
  State<ProjectGallery> createState() => _ProjectGalleryState();
}

class _ProjectGalleryState extends State<ProjectGallery> {
  int _selectedIndex = 0;

  void _showPreviousImage() {
    if (widget.imagePaths.isEmpty) return;

    setState(() {
      _selectedIndex = _selectedIndex == 0
          ? widget.imagePaths.length - 1
          : _selectedIndex - 1;
    });
  }

  void _showNextImage() {
    if (widget.imagePaths.isEmpty) return;

    setState(() {
      _selectedIndex = (_selectedIndex + 1) % widget.imagePaths.length;
    });
  }

  void _selectImage(int index) {
    if (index < 0 || index >= widget.imagePaths.length) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void didUpdateWidget(covariant ProjectGallery oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.imagePaths != widget.imagePaths) {
      _selectedIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.imagePaths.isEmpty) {
      return _buildEmptyGallery(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildMainImage(context),
        const SizedBox(height: 20),
        _buildThumbnails(context),
      ],
    );
  }

  Widget _buildMainImage(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      height: 560,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: Border.all(color: theme.dividerColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image.asset(
              widget.imagePaths[_selectedIndex],
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return _buildImageError(context);
              },
            ),
          ),

          // Image counter
          Positioned(
            top: 20,
            right: 24,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: colors.surface.withValues(alpha: 0.92),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Text(
                '${_selectedIndex + 1} / ${widget.imagePaths.length}',
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),

          // Previous image
          Positioned(
            left: 20,
            child: _buildNavigationButton(
              context: context,
              icon: Icons.chevron_left,
              onPressed: _showPreviousImage,
            ),
          ),

          // Next image
          Positioned(
            right: 20,
            child: _buildNavigationButton(
              context: context,
              icon: Icons.chevron_right,
              onPressed: _showNextImage,
            ),
          ),

          // Image indicators
          Positioned(bottom: 20, child: _buildIndicators(context)),
        ],
      ),
    );
  }

  Widget _buildNavigationButton({
    required BuildContext context,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surface.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Icon(icon, color: colors.onSurface, size: 30),
        ),
      ),
    );
  }

  Widget _buildIndicators(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: colors.surface.withValues(alpha: 0.88),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.imagePaths.length, (index) {
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () => _selectImage(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isSelected ? 22 : 10,
              height: 10,
              decoration: BoxDecoration(
                color: isSelected
                    ? colors.primary
                    : colors.onSurface.withValues(alpha: 0.35),
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildThumbnails(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SizedBox(
      height: 145,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.imagePaths.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () => _selectImage(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 220,
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? colors.primary : theme.dividerColor,
                  width: isSelected ? 2 : 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                widget.imagePaths[index],
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return _buildImageError(context);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyGallery(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 400,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSizes.radiusLG),
        border: Border.all(color: theme.dividerColor),
      ),
      child: _buildImageError(context),
    );
  }

  Widget _buildImageError(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.image_not_supported_outlined,
            color: colors.onSurface.withValues(alpha: 0.5),
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            'Image unavailable',
            style: TextStyle(color: colors.onSurface.withValues(alpha: 0.75)),
          ),
        ],
      ),
    );
  }
}
