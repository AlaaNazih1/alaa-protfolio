import 'package:flutter/material.dart';

import 'package:alaa_protfolio/features/experience/presentation/models/experience_model.dart';

abstract final class ExperienceData {
  static const List<ExperienceModel> experiences = [
    ExperienceModel(
      title: 'Flutter Developer Trainee',
      organization: 'NTI (National Telecommunication Institute)',
      startDate: '23 Nov 2025',
      endDate: '04 Feb 2026',
      description:
          'Hands-on training in Flutter development, Firebase, '
          'state management, and building cross-platform mobile '
          'applications.',
      icon: Icons.work_outline_rounded,
      color: Color(0xFF3B82F6),
    ),
    ExperienceModel(
      title: 'Flutter Developer Trainee',
      organization: 'Digital Egypt Pioneers Initiative (DEPI)',
      startDate: 'Nov 2025',
      endDate: 'Jul 2026',
      description:
          'Software development training focused on Flutter, '
          'clean architecture, state management, and professional '
          'mobile application development.',
      icon: Icons.work_outline_rounded,
      color: Color(0xFF34D399),
    ),
  ];
}
