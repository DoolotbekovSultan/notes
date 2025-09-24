part of 'notes_bloc.dart';

sealed class NotesEvent {}

final class LoadAllNotesEvent extends NotesEvent {}

final class LoadNoteEvent extends NotesEvent {
  final int? id;
  LoadNoteEvent(this.id);
}

final class SaveNoteEvent extends NotesEvent {}

final class ChangeLayoutEvent extends NotesEvent {}

final class NoteEditedEvent extends NotesEvent {
  final String? title;
  final String? description;
  final Color? color;
  NoteEditedEvent({this.title, this.description, this.color});
}

final class DescriptionEditedEvent extends NotesEvent {
  final String description;
  DescriptionEditedEvent(this.description);
}

final class ChangeColorButtonClickedEvent extends NotesEvent {}

final class ChangeColorDialogClosedEvent extends NotesEvent {}

final class AddNoteButtonClickedEvent extends NotesEvent {}

final class BackNavigateEvent extends NotesEvent {}
