import 'package:flutter/material.dart';

import 'package:alaa_protfolio/core/constant/app_sizes.dart';
import 'package:alaa_protfolio/features/contact/presentation/widgets/contact_info.dart';
import 'package:alaa_protfolio/features/contact/presentation/widgets/contact_form.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      key: const ValueKey('contact-section'),
      width: double.infinity,
      color: theme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 64),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: AppSizes.maxWidth),
          child: Column(
            children: [
              _buildHeader(context),
              const SizedBox(height: 64),
              _buildContactContent(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        Text(
          'Get In Touch',
          style: TextStyle(
            color: colors.secondary,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final isMobile = constraints.maxWidth < 500;

            return Text(
              "Let's Work Together",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: colors.onSurface,
                fontSize: isMobile ? 30 : 42,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 650),
          child: Text(
            "Have a project in mind? Let's discuss how I can help "
            'bring your vision to life.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.onSurface.withValues(alpha: 0.75),
              fontSize: 18,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;

        if (isMobile) {
          return const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [ContactInfo(), SizedBox(height: 40), ContactForm()],
          );
        }

        return const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: ContactInfo()),
            SizedBox(width: 48),
            Expanded(flex: 5, child: ContactForm()),
          ],
        );
      },
    );
  }
}
