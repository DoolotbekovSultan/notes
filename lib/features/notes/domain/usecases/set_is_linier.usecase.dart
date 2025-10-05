import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/notes/domain/failure/notes_failure.dart';
import 'package:note/features/notes/domain/repositories/i_note_repository.dart';

@lazySingleton
class SetIsLinearUsecase extends BaseUsecase {
  final INoteRepository _repository;
  SetIsLinearUsecase(this._repository);

  Future<Either<SetIsLinierFailure, void>> call(bool newIsLinier) async {
    return baseCallWrapper<SetIsLinierFailure, void>(
      action: () async => await _repository.setIsLinier(newIsLinier),
      failureFactory: (e) => SetIsLinierFailure(e),
      loggerErrorMessage:
          "Usecase(SetIsLinearUsecase): ошибка изменения дынных",
      loggerSuccessMessage:
          'UseCase(SetIsLinearUsecase): успешно изменино на isLinier = $newIsLinier',
    );
  }
}
