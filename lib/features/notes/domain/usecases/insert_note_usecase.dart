import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class InsertNoteUsecase {
  final INoteRepository _repository;
  const InsertNoteUsecase(this._repository);

  Future<Either<InsertNoteFailure, void>> call(Note note) async {
    final result = await _repository.insertNote(note);
    result.fold(
      (failure) => logger.e(
        "Usecase(GetAllNotesUsecase): ошибка при добавлении данных",
        error: failure.exception,
      ),
      (_) => logger.i(
        'UseCase(GetAllNotesUsecase): успешно добавлено note = $note',
      ),
    );
    return result;
  }
}
