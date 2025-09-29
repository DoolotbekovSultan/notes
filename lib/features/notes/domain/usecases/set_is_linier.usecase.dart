import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class SetIsLinearUsecase {
  final INoteRepository _repository;
  const SetIsLinearUsecase(this._repository);

  Future<Either<SetIsLinierFailure, void>> call(bool newIsLinier) async {
    final result = await _repository.setIsLinier(newIsLinier);
    result.fold(
      (failure) => logger.e(
        "Usecase(SetIsLinearUsecase): ошибка изменения дынных",
        error: failure.exception,
      ),
      (isLinier) => logger.i(
        'UseCase(SetIsLinearUsecase): успешно изменино на isLinier = $newIsLinier]',
      ),
    );
    return result;
  }
}
