import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/data/datasources/i_note_local_datasource.dart';
import 'package:note/features/notes/data/mappers/notes_extentions.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@LazySingleton(as: INoteRepository)
class NoteRepository extends INoteRepository {
  final INoteLocalDatasource _localDatasource;
  NoteRepository(this._localDatasource);

  @override
  Future<Either<GetAllNotesFailure, List<Note>>> getAllNotes() async {
    try {
      final result = await _localDatasource.getAllNotes();
      final entities = result.toDomains();
      logger.d("Repository(NoteRepository): result = $result");
      return Right(entities);
    } catch (e, st) {
      logger.e(
        "Repository(NoteRepository): ошибка при попытке получения notes с db",
        error: e,
        stackTrace: st,
      );
      return Left(GetAllNotesFailure(e as Exception));
    }
  }

  @override
  Future<Either<InsertNoteFailure, void>> insertNote(Note note) async {
    try {
      final model = note.toModel();
      final result = await _localDatasource.insertNote(model);
      logger.d(
        "Repository(NoteRepository): успешно добавлен в dp note = $note",
      );
      return Right(result);
    } catch (e, st) {
      logger.e(
        "Repository(NoteRepository): ошибка при попытке добавления note в db",
        error: e,
        stackTrace: st,
      );
      return Left(InsertNoteFailure(e as Exception));
    }
  }
}
