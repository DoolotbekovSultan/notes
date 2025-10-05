import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';
import 'package:note/features/onboarding/domain/repositories/i_onboarding_repository.dart';

@lazySingleton
class WasSeenOnboardingUsecase extends BaseUsecase {
  final IOnboardingRepository _repository;
  WasSeenOnboardingUsecase(this._repository);

  Future<Either<WriteOnboardingFailure, void>> call() async {
    return baseCallWrapper<WriteOnboardingFailure, void>(
      action: () => _repository.wasSeenOnboarding(),
      failureFactory: (exception) => WriteOnboardingFailure(exception),
      loggerSuccessMessage:
          'UseCase(WasSeenOnboardingUsecase): успешно записано hasSeenOnboarding',
      loggerErrorMessage:
          'UseCase(WasSeenOnboardingUsecase): ошибка записи hasSeenOnboarding',
    );
  }
}
