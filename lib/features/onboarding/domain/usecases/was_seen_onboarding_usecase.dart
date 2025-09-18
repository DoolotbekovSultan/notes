import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';
import 'package:note/features/onboarding/domain/repositories/i_onboarding_repository.dart';

@lazySingleton
class WasSeenOnboardingUsecase {
  final IOnboardingRepository _repository;
  const WasSeenOnboardingUsecase(this._repository);
  Future<Either<WriteOnboardingFailure, void>> call() async {
    final result = await _repository.wasSeenOnboarding();

    result.fold(
      (failure) => logger.e(
        'UseCase(WasSeenOnboardUsecase): ошибка записи hasSeenOnboard',
        error: failure.exception,
      ),
      (_) => logger.i(
        'UseCase(WasSeenOnboardUsecase): hasSeenOnboard успешно отмечен как просмотренный',
      ),
    );

    return result;
  }
}
