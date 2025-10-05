import 'package:dartz/dartz.dart';
import 'package:note/core/utils/logger.dart';

class BaseRepository {
  Future<Either<Failure, Success>> baseMethodWrapper<Failure, Success>({
    required Future<Success> Function() action,
    required Failure Function(Exception) failureFactory,
    String loggerErrorMessage =
        "Repository(Unknown): ошибка при выполнении действия",
  }) async {
    try {
      final result = await action();
      return Right(result);
    } catch (e, st) {
      logger.e(loggerErrorMessage, error: e, stackTrace: st);
      return Left(failureFactory(e as Exception));
    }
  }
}
