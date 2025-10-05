import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class DeleteNoteUsecase extends BaseUsecase {
  final INoteRepository _repository;
  DeleteNoteUsecase(this._repository);

  Future<Either<DeleteNoteFailure, void>> call(Note note) async {
    return baseCallWrapper<DeleteNoteFailure, void>(
      action: () async => await _repository.deleteNote(note),
      failureFactory: (e) => DeleteNoteFailure(e),
      loggerErrorMessage:
          "Usecase(DeleteNoteUsecase): ошибка при удалении note = $note",
      loggerSuccessMessage:
          'UseCase(DeleteNoteUsecase): успешно удалено note = $note',
    );
  }
}
