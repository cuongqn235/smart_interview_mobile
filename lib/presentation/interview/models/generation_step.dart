import 'package:flutter/material.dart';

class GenerationStep {
  final IconData icon;
  final String title;
  final String description;
  final LinearGradient gradient;
  final int duration;

  GenerationStep({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
    required this.duration,
  });
}
