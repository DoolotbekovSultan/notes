import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetAllNotesUsecase extends BaseUsecase {
  final INoteRepository _repository;
  GetAllNotesUsecase(this._repository);

  Future<Either<LoadAllNotesFailure, List<Note>>> call() async {
    return baseCallWrapper<LoadAllNotesFailure, List<Note>>(
      action: () async => await _repository.getAllNotes(),
      failureFactory: (e) => LoadAllNotesFailure(e),
      loggerErrorMessage:
          "Usecase(GetAllNotesUsecase): ошибка при получении всех notes",
      loggerSuccessMessage:
          'UseCase(GetAllNotesUsecase): успешно получены все notes',
    );
  }
}
