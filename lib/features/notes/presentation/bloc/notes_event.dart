part of 'notes_bloc.dart';

sealed class NotesEvent {}

final class LoadAllNotesEvent extends NotesEvent {}

final class LoadNoteEvent extends NotesEvent {
  final int? id;
  LoadNoteEvent(this.id);
}

final class SearchNotesEvent extends NotesEvent {
  final String query;
  SearchNotesEvent(this.query);
}

final class SaveNoteEvent extends NotesEvent {}

final class DeleteNoteEvent extends NotesEvent {
  final Note? note;
  DeleteNoteEvent({this.note});
}

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

final class DeleteNoteClickedEvent extends NotesEvent {}

final class NoteLongPressedEvent extends NotesEvent {
  final Note? note;
  NoteLongPressedEvent({this.note});
}

final class ChangeColorButtonClickedEvent extends NotesEvent {}

final class ChangeColorDialogClosedEvent extends NotesEvent {}

final class AddNoteButtonClickedEvent extends NotesEvent {}

final class BackNavigateEvent extends NotesEvent {}
