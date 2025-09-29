import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetIsLinearUsecase {
  final INoteRepository _repository;
  const GetIsLinearUsecase(this._repository);

  Future<Either<GetIsLinierFailure, bool>> call() async {
    final result = await _repository.gettIsLinier();
    result.fold(
      (failure) => logger.e(
        "Usecase(GetIsLinearUsecase): ошибка чтения дынных",
        error: failure.exception,
      ),
      (isLinier) => logger.i(
        'UseCase(GetIsLinearUsecase): успешно получено isLinier = $isLinier',
      ),
    );
    return result;
  }
}
