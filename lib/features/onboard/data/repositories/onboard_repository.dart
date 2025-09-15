import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboard/data/datasouces/onboard_local_datasource.dart';
import 'package:note/features/onboard/domain/failure/onboard_failure.dart';
import 'package:note/features/onboard/domain/repositories/i_onboard_repository.dart';

@LazySingleton(as: IOnboardRepository)
class OnboardRepository implements IOnboardRepository {
  final OnboardLocalDatasource _localDatasource;
  const OnboardRepository(this._localDatasource);

  @override
  Future<Either<ReadOnboardFailure, bool>> hasSeenOnboard() async {
    try {
      final result = await _localDatasource.hasSeenOnboard();
      logger.d("Repository(OnboardRepository): hasSeenOnboard = $result");
      return Right(result);
    } catch (e, st) {
      logger.e(
        'Repository(OnboardRepository): ошибка при чтении hasSeenOnboard',
        error: e,
        stackTrace: st,
      );
      return Left(ReadOnboardFailure(e as Exception));
    }
  }

  @override
  Future<Either<WriteOnboardFailure, void>> wasSeenOnboard() async {
    try {
      final result = await _localDatasource.wasSeenOnboard();
      logger.d("Repository(OnboardRepository): hasSeenOnboard = true");
      return Right(result);
    } catch (e, st) {
      logger.e(
        'Repository(OnboardRepository): ошибка при записи hasSeenOnboard',
        error: e,
        stackTrace: st,
      );
      return Left(WriteOnboardFailure(e as Exception));
    }
  }
}
