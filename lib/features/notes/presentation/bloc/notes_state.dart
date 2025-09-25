part of 'notes_bloc.dart';

sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesLoadedSuccess extends NotesState {
  final List<Note> notes;
  final LayoutType layoutType;
  NotesLoadedSuccess(this.notes, this.layoutType);
}

final class NoteLoadedSuccess extends NotesState {
  final bool showReadyText;
  final bool isChangeColor;
  final Note note;
  NoteLoadedSuccess(
    this.note, {
    this.showReadyText = false,
    this.isChangeColor = false,
  });
}

final class NavigateNoteScreen extends NotesState {
  final int? id;
  NavigateNoteScreen({this.id});
}

final class ShowAskDeleteDialog extends NotesState {
  final Note? note;
  ShowAskDeleteDialog({this.note});
}

final class ShowColorChangeDialog extends NotesState {}

final class NavigateNotesScreen extends NotesState {}

final class NoteInsertedSuccess extends NotesState {}

final class NotesError extends NotesState {
  final NotesFailure failure;
  NotesError(this.failure);
}
