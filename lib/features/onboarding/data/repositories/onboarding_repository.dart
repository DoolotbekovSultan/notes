import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboarding/data/datasouces/i_onboarding_local_datasource.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';
import 'package:note/features/onboarding/domain/repositories/i_onboarding_repository.dart';

@LazySingleton(as: IOnboardingRepository)
class OnboardingRepository implements IOnboardingRepository {
  final IOnboardingLocalDatasource _localDatasource;
  const OnboardingRepository(this._localDatasource);

  @override
  Future<Either<ReadOnboardingFailure, bool>> hasSeenOnboarding() async {
    try {
      final result = await _localDatasource.hasSeenOnboarding();
      logger.d("Repository(OnboardingRepository): hasSeenOnboarding = $result");
      return Right(result);
    } catch (e, st) {
      logger.e(
        'Repository(OnboardingRepository): ошибка при чтении hasSeenOnboarding',
        error: e,
        stackTrace: st,
      );
      return Left(ReadOnboardingFailure(e as Exception));
    }
  }

  @override
  Future<Either<WriteOnboardingFailure, void>> wasSeenOnboarding() async {
    try {
      final result = await _localDatasource.wasSeenOnboarding();
      logger.d("Repository(OnboardingRepository): hasSeenOnboarding = true");
      return Right(result);
    } catch (e, st) {
      logger.e(
        'Repository(OnboardingRepository): ошибка при записи hasSeenOnboarding',
        error: e,
        stackTrace: st,
      );
      return Left(WriteOnboardingFailure(e as Exception));
    }
  }
}
