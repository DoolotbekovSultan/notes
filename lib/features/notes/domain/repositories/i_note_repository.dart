import 'package:dartz/dartz.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';

abstract class INoteRepository {
  Future<Either<LoadAllNotesFailure, List<Note>>> getAllNotes();
  Future<Either<InsertNoteFailure, void>> insertNote(Note note);
  Future<Either<DeleteNoteFailure, void>> deleteNote(Note note);
  Future<Either<LoadNoteFailure, Note?>> getNoteById(int id);
  Future<Either<SearchNotesFailure, List<Note>>> searchNotes(String query);
}
