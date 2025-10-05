import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class InsertNoteUsecase extends BaseUsecase {
  final INoteRepository _repository;
  InsertNoteUsecase(this._repository);

  Future<Either<InsertNoteFailure, void>> call(Note note) async {
    return baseCallWrapper<InsertNoteFailure, void>(
      action: () async => await _repository.insertNote(note),
      failureFactory: (e) => InsertNoteFailure(e),
      loggerErrorMessage:
          "Usecase(InsertNoteUsecase): ошибка при добавлении данных",
      loggerSuccessMessage:
          'UseCase(InsertNoteUsecase): успешно добавлено note = $note',
    );
  }
}
