part of 'notes_bloc.dart';

sealed class NotesEvent {}

final class GetAllNotesEvent extends NotesEvent {}

final class InsertNoteEvent extends NotesEvent {
  final Note note;
  InsertNoteEvent(this.note);
}

final class ChangeLayoutEvent extends NotesEvent {}
