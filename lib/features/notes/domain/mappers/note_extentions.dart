import 'package:flutter/material.dart';
import 'package:note/features/notes/domain/entities/note.dart';

extension NoteExtentions on Note {
  Note copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dateTime,
    Color? color,
  }) => Note(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    dateTime: dateTime ?? this.dateTime,
    color: color ?? this.color,
  );
}
