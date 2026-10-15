import 'package:flutter/material.dart';

class ExperienceModel {
  const ExperienceModel({
    required this.title,
    required this.organization,
    required this.startDate,
    required this.endDate,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String organization;
  final String startDate;
  final String endDate;
  final String description;
  final IconData icon;
  final Color color;

  String get dateRange => '$startDate — $endDate';
}
