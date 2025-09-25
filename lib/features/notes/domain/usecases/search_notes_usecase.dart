import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class SearchNotesUsecase {
  final INoteRepository _repository;
  const SearchNotesUsecase(this._repository);

  Future<Either<SearchNotesFailure, List<Note>>> call(String query) async {
    final result = await _repository.searchNotes(query);
    result.fold(
      (failure) => logger.e(
        "Usecase(SearchNotesUsecase): ошибка получения данных",
        error: failure.exception,
      ),
      (notes) => logger.i(
        'UseCase(SearchNotesUsecase): успешно получено notes = $notes',
      ),
    );
    return result;
  }
}
