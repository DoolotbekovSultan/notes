import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboard/data/repositories/onboard_repository.dart';
import 'package:note/features/onboard/domain/failure/onboard_failure.dart';

@lazySingleton
class HasSeenOnboardUsecase {
  final OnboardRepository _repository;
  const HasSeenOnboardUsecase(this._repository);
  Future<Either<ReadOnboardFailure, bool>> call() async {
    final result = await _repository.hasSeenOnboard();
    result.fold(
      (failure) {
        logger.e(
          "Usecase(HasSeenOnboardUsecase): ошибка чтения hasSeenOnboard",
          error: failure.exception,
        );
      },
      (hasSeenOnboard) {
        logger.i(
          'UseCase(HasSeenOnboardUsecase): успешно прочитано hasSeenOnboard = $hasSeenOnboard',
        );
      },
    );
    return result;
  }
}
