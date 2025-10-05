import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/usecases/base_usecase.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';
import 'package:note/features/onboarding/domain/repositories/i_onboarding_repository.dart';

@lazySingleton
class HasSeenOnboardingUsecase extends BaseUsecase {
  final IOnboardingRepository _repository;
  HasSeenOnboardingUsecase(this._repository);

  Future<Either<ReadOnboardingFailure, bool>> call() async {
    return baseCallWrapper<ReadOnboardingFailure, bool>(
      action: () => _repository.hasSeenOnboarding(),
      failureFactory: (exception) => ReadOnboardingFailure(exception),
      loggerSuccessMessage:
          'UseCase(HasSeenOnboardingUsecase): успешно прочитано hasSeenOnboarding',
      loggerErrorMessage:
          'Usecase(HasSeenOnboardingUsecase): ошибка чтения hasSeenOnboarding',
    );
  }
}
