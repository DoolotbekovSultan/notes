import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Note {
  final int? id;
  final String title;
  final String description;
  final DateTime dateTime;
  final Color color;

  Note({
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.color = const Color(0xFFFFF599),
  });
}
