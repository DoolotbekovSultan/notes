import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class GetIsLinearUsecase extends BaseUsecase {
  final INoteRepository _repository;
  GetIsLinearUsecase(this._repository);

  Future<Either<GetIsLinierFailure, bool>> call() async {
    return baseCallWrapper<GetIsLinierFailure, bool>(
      action: () async => await _repository.gettIsLinier(),
      failureFactory: (e) => GetIsLinierFailure(e),
      loggerErrorMessage: "Usecase(GetIsLinearUsecase): ошибка чтения дынных",
      loggerSuccessMessage:
          'UseCase(GetIsLinearUsecase): успешно получено isLinier',
    );
  }
}
