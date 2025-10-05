import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/notes/domain/entities/note.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class SearchNotesUsecase extends BaseUsecase {
  final INoteRepository _repository;
  SearchNotesUsecase(this._repository);

  Future<Either<SearchNotesFailure, List<Note>>> call(String query) async {
    return baseCallWrapper<SearchNotesFailure, List<Note>>(
      action: () async => await _repository.searchNotes(query),
      failureFactory: (e) => SearchNotesFailure(e),
      loggerErrorMessage:
          "Usecase(SearchNotesUsecase): ошибка получения данных",
      loggerSuccessMessage:
          'UseCase(SearchNotesUsecase): успешно получено notes',
    );
  }
}
