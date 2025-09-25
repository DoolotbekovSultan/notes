import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class DeleteNoteUsecase {
  final INoteRepository _repository;
  const DeleteNoteUsecase(this._repository);

  Future<Either<DeleteNoteFailure, void>> call(Note note) async {
    final result = await _repository.deleteNote(note);
    result.fold(
      (failure) => logger.e(
        "Usecase(DeleteNoteUsecase): ошибка при удалении данных",
        error: failure.exception,
      ),
      (_) =>
          logger.i('UseCase(DeleteNoteUsecase): успешно удалено note = $note'),
    );
    return result;
  }
}
