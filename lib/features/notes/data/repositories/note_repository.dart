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
  Future<Either<LoadAllNotesFailure, List<Note>>> getAllNotes() async {
    try {
      final result = await _localDatasource.getAllNoteModels();
      final entities = result.toDomains();
      logger.d("Repository(NoteRepository): result = $result");
      return Right(entities);
    } catch (e, st) {
      logger.e(
        "Repository(NoteRepository): ошибка при попытке получения notes с db",
        error: e,
        stackTrace: st,
      );
      return Left(LoadAllNotesFailure(e as Exception));
    }
  }

  @override
  Future<Either<SearchNotesFailure, List<Note>>> searchNotes(
    String query,
  ) async {
    try {
      final result = await _localDatasource.searchNoteModels(query);
      final entities = result.toDomains();
      logger.d("Repository(NoteRepository): search($query) result = $result");
      return Right(entities);
    } catch (e, st) {
      logger.e(
        "Repository(NoteRepository): ошибка при попытке поиска notes в db",
        error: e,
        stackTrace: st,
      );
      return Left(SearchNotesFailure(e as Exception));
    }
  }

  @override
  Future<Either<InsertNoteFailure, void>> insertNote(Note note) async {
    try {
      final model = note.toModel();
      final result = await _localDatasource.insertNoteModel(model);
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

  @override
  Future<Either<DeleteNoteFailure, void>> deleteNote(Note note) async {
    try {
      final model = note.toModel();
      final result = await _localDatasource.deleteNoteModel(model);
      logger.d("Repository(NoteRepository): успешно удален в dp note = $note");
      return Right(result);
    } catch (e, st) {
      logger.e(
        "Repository(NoteRepository): ошибка при попытке удаления note в db",
        error: e,
        stackTrace: st,
      );
      return Left(DeleteNoteFailure(e as Exception));
    }
  }

  @override
  Future<Either<LoadNoteFailure, Note?>> getNoteById(int id) async {
    try {
      final result = await _localDatasource.getNoteModelById(id);
      final entity = result?.toDomain();
      logger.d("Repository(NoteRepository): result = $entity");
      return Right(entity);
    } catch (e, st) {
      logger.e(
        "Repository(NoteRepository): ошибка при попытке получения note c db",
        error: e,
        stackTrace: st,
      );
      return Left(LoadNoteFailure(e as Exception));
    }
  }
}
