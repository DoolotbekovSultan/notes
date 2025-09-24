import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetNoteUsecase {
  final INoteRepository _repository;
  const GetNoteUsecase(this._repository);

  Future<Either<LoadNoteFailure, Note?>> call(int id) async {
    final result = await _repository.getNoteById(id);
    result.fold(
      (failure) => logger.e(
        "Usecase(GetNoteUsecase): ошибка получения данных",
        error: failure.exception,
      ),
      (note) =>
          logger.i('UseCase(GetNoteUsecase): успешно получено note = $note'),
    );
    return result;
  }
}
