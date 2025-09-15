import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:note/core/utils/logger.dart';
import 'package:note/features/onboard/data/repositories/onboard_repository.dart';
import 'package:note/features/onboard/domain/failure/onboard_failure.dart';

@lazySingleton
class WasSeenOnboardUsecase {
  final OnboardRepository repository;
  const WasSeenOnboardUsecase(this.repository);
  Future<Either<WriteOnboardFailure, void>> call() async {
    final result = await repository.wasSeenOnboard();

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
