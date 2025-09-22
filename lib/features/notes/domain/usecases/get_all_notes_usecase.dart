import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetAllNotesUsecase {
  final INoteRepository _repository;
  const GetAllNotesUsecase(this._repository);

  Future<Either<GetAllNotesFailure, List<Note>>> call() async {
    final result = await _repository.getAllNotes();
    result.fold(
      (failure) => logger.e(
        "Usecase(GetAllNotesUsecase): ошибка получения данных",
        error: failure.exception,
      ),
      (notes) => logger.i(
        'UseCase(GetAllNotesUsecase): успешно получено notes = $notes',
      ),
    );
    return result;
  }
}
