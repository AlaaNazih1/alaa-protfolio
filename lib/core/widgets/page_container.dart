import 'package:alaa_protfolio/core/constant/app_sizes.dart';
import 'package:flutter/material.dart';


class PageContainer extends StatelessWidget {
  const PageContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: child,
        ),
      ),
    );
  }
}
