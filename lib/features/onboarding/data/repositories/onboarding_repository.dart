import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/basic/repositories/base_repository.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboarding/data/datasouces/i_onboarding_local_datasource.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';
import 'package:note/features/onboarding/domain/repositories/i_onboarding_repository.dart';

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepository extends BaseRepository
    implements IOnboardingRepository {
  final IOnboardingLocalDatasource _localDatasource;
  OnboardingRepository(this._localDatasource);

  @override
  Future<Either<ReadOnboardingFailure, bool>> hasSeenOnboarding() async {
    return baseMethodWrapper<ReadOnboardingFailure, bool>(
      action: () async {
        final result = await _localDatasource.hasSeenOnboarding();
        logger.d(
          "Repository(OnboardingRepository): hasSeenOnboarding = $result",
        );
        return result;
      },
      failureFactory: (e) => ReadOnboardingFailure(e),
      loggerErrorMessage:
          "Repository(OnboardingRepository): ошибка при чтении hasSeenOnboarding",
    );
  }

  @override
  Future<Either<WriteOnboardingFailure, void>> wasSeenOnboarding() async {
    return baseMethodWrapper<WriteOnboardingFailure, void>(
      action: () async {
        final result = await _localDatasource.wasSeenOnboarding();
        logger.d("Repository(OnboardingRepository): hasSeenOnboarding = true");
        return result;
      },
      failureFactory: (e) => WriteOnboardingFailure(e),
      loggerErrorMessage:
          'Repository(OnboardingRepository): ошибка при записи hasSeenOnboarding',
    );
  }
}
