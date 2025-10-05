import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/repositories/base_repository.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/data/datasources/i_note_local_datasource.dart';
import 'package:note/features/notes/data/mappers/notes_extentions.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@LazySingleton(as: INoteRepository)
class NoteRepository extends BaseRepository implements INoteRepository {
  final INoteLocalDatasource _localDatasource;
  NoteRepository(this._localDatasource);

  @override
  Future<Either<LoadAllNotesFailure, List<Note>>> getAllNotes() async {
    return baseMethodWrapper<LoadAllNotesFailure, List<Note>>(
      action: () async {
        final result = await _localDatasource.getAllNoteModels();
        final entities = result.toDomains();
        entities.sort(
          (a, b) => b.dateTime.compareTo(a.dateTime),
        ); //  сортировка по дате
        logger.d("Repository(NoteRepository): result = $result");
        return entities;
      },
      failureFactory: (e) => LoadAllNotesFailure(e),
      loggerErrorMessage:
          "Repository(NoteRepository): ошибка при попытке получения notes с db",
    );
  }

  @override
  Future<Either<SearchNotesFailure, List<Note>>> searchNotes(
    String query,
  ) async {
    return baseMethodWrapper<SearchNotesFailure, List<Note>>(
      action: () async {
        final result = await _localDatasource.searchNoteModels(query);
        final entities = result.toDomains();
        entities.sort(
          (a, b) => b.dateTime.compareTo(a.dateTime),
        ); //  сортировка по дате
        logger.d("Repository(NoteRepository): search($query) result = $result");
        return entities;
      },
      failureFactory: (e) => SearchNotesFailure(e),
      loggerErrorMessage:
          "Repository(NoteRepository): ошибка при попытке поиска notes в db",
    );
  }

  @override
  Future<Either<InsertNoteFailure, void>> insertNote(Note note) async {
    return baseMethodWrapper<InsertNoteFailure, void>(
      action: () async {
        final model = note.toModel();
        final result = await _localDatasource.insertNoteModel(model);
        logger.d(
          "Repository(NoteRepository): успешно добавлен в dp note = $note",
        );
        return result;
      },
      failureFactory: (e) => InsertNoteFailure(e),
      loggerErrorMessage:
          "Repository(NoteRepository): ошибка при попытке добавления note в db",
    );
  }

  @override
  Future<Either<DeleteNoteFailure, void>> deleteNote(Note note) async {
    return baseMethodWrapper<DeleteNoteFailure, void>(
      action: () async {
        final model = note.toModel();
        final result = await _localDatasource.deleteNoteModel(model);
        logger.d(
          "Repository(NoteRepository): успешно удален в dp note = $note",
        );
        return result;
      },
      failureFactory: (e) => DeleteNoteFailure(e),
      loggerErrorMessage:
          "Repository(NoteRepository): ошибка при попытке удаления note в db",
    );
  }

  @override
  Future<Either<LoadNoteFailure, Note?>> getNoteById(int id) async {
    return baseMethodWrapper<LoadNoteFailure, Note?>(
      action: () async {
        final result = await _localDatasource.getNoteModelById(id);
        final entity = result?.toDomain();
        logger.d("Repository(NoteRepository): result = $entity");
        return entity;
      },
      failureFactory: (e) => LoadNoteFailure(e),
      loggerErrorMessage:
          "Repository(NoteRepository): ошибка при попытке получения note c db",
    );
  }

  @override
  Future<Either<GetIsLinierFailure, bool>> gettIsLinier() async {
    return baseMethodWrapper<GetIsLinierFailure, bool>(
      action: () async {
        final result = await _localDatasource.getIsLinier();
        logger.d("Repository(OnboardingRepository): isLinier = $result");
        return result;
      },
      failureFactory: (e) => GetIsLinierFailure(e),
      loggerErrorMessage:
          "Repository(OnboardingRepository): ошибка при чтении hasSeenOnboarding",
    );
  }

  @override
  Future<Either<SetIsLinierFailure, void>> setIsLinier(bool isLinier) async {
    return baseMethodWrapper<SetIsLinierFailure, void>(
      action: () async {
        final result = await _localDatasource.setIsLinier(isLinier);
        logger.d(
          "Repository(OnboardingRepository): isLinier успешно изменен на = $isLinier",
        );
        return result;
      },
      failureFactory: (e) => SetIsLinierFailure(e),
      loggerErrorMessage:
          "Repository(OnboardingRepository): ошибка при изменении isLinier",
    );
  }
}
