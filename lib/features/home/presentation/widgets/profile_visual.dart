import 'package:flutter/material.dart';

import '../../../../core/constant/app_sizes.dart';

class ProfileVisual extends StatelessWidget {
  const ProfileVisual({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : 460.0;

        final visualSize = width.clamp(280.0, 460.0);

        return Center(
          child: SizedBox(
            width: visualSize,
            height: visualSize,
            child: Stack(
              alignment: Alignment.center,
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: visualSize * 0.78,
                  height: visualSize * 0.86,
                  decoration: BoxDecoration(
                    color: colors.surface,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                    border: Border.all(color: theme.dividerColor),
                    boxShadow: [
                      BoxShadow(
                        color: colors.primary.withValues(
                          alpha: theme.brightness == Brightness.dark
                              ? 0.16
                              : 0.10,
                        ),
                        blurRadius: 60,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                ),

                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: visualSize * 0.08,
                      right: visualSize * 0.08,
                      top: visualSize * 0.07,
                      bottom: visualSize * 0.07,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppSizes.radiusXL),
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        alignment: const Alignment(0, -0.2),
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: colors.surface,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.person_outline_rounded,
                              color: colors.onSurface.withValues(alpha: 0.55),
                              size: 90,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),

               

               

              

               
              ],
            ),
          ),
        );
      },
    );
  }
}

