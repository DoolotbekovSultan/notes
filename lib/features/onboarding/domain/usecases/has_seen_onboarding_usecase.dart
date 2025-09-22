import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';
import 'package:note/features/onboarding/domain/repositories/i_onboarding_repository.dart';

@lazySingleton
class HasSeenOnboardingUsecase {
  final IOnboardingRepository _repository;
  const HasSeenOnboardingUsecase(this._repository);
  Future<Either<ReadOnboardingFailure, bool>> call() async {
    final result = await _repository.hasSeenOnboarding();
    result.fold(
      (failure) => logger.e(
        "Usecase(HasSeenOnboardingUsecase): ошибка чтения hasSeenOnboarding",
        error: failure.exception,
      ),
      (hasSeenOnboarding) => logger.i(
        'UseCase(HasSeenOnboardingUsecase): успешно прочитано hasSeenOnboarding = $hasSeenOnboarding',
      ),
    );
    return result;
  }
}
