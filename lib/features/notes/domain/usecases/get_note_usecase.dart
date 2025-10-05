import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetNoteUsecase extends BaseUsecase {
  final INoteRepository _repository;
  GetNoteUsecase(this._repository);

  Future<Either<LoadNoteFailure, Note?>> call(int id) async {
    return baseCallWrapper<LoadNoteFailure, Note?>(
      action: () async => await _repository.getNoteById(id),
      failureFactory: (e) => LoadNoteFailure(e),
      loggerErrorMessage: "Usecase(GetNoteUsecase): ошибка получения данных",
      loggerSuccessMessage: 'UseCase(GetNoteUsecase): успешно получено note',
    );
  }
}
