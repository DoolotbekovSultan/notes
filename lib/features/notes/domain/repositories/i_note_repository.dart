import 'package:dartz/dartz.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';

abstract class INoteRepository {
  Future<Either<GetAllNotesFailure, List<Note>>> getAllNotes();
  Future<Either<InsertNoteFailure, void>> insertNote(Note note);
}
