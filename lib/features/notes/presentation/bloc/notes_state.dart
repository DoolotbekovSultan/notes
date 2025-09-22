part of 'notes_bloc.dart';

sealed class NotesState {}

final class NotesInitial extends NotesState {}

final class NotesLoading extends NotesState {}

final class NotesLoadedSuccess extends NotesState {
  final List<Note> notes;
  final LayoutType layoutType;
  NotesLoadedSuccess(this.notes, this.layoutType);
}

final class NotesError extends NotesState {
  final NotesFailure failure;
  NotesError(this.failure);
}
