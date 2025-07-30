// lib/data/models/routine.dart
import 'package:flutter/material.dart';

class Routine {
  final String id;
  final String title;
  final String time;
  final String days;
  final IconData icon;
  bool isActive;

  Routine({
    required this.id,
    required this.title,
    required this.time,
    required this.days,
    required this.icon,
    this.isActive = true,
  });
}