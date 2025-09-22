import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:note/features/notes/utils/type_coverters/color_converter.dart';
import 'package:note/features/notes/utils/type_coverters/date_time_converter.dart';

@entity
class NoteModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String description;
  @TypeConverters([DateTimeConverter])
  final DateTime dateTime;
  @TypeConverters([ColorConverter])
  final Color color;

  NoteModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.color,
  });
}
