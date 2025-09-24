import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note/features/notes/utils/note_colors.dart';

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
    Color? color,
  }) : color = color ?? noteColors.first;
}
