import 'package:dartz/dartz.dart';
import 'package:note/core/utils/logger.dart';

class BaseUsecase {
  Future<Either<Failure, Success>> baseCallWrapper<Failure, Success>({
    required Future<Either<Failure, Success>> Function() action,
    required Failure Function(Exception) failureFactory,
    required String loggerSuccessMessage,
    required String loggerErrorMessage,
  }) async {
    final result = await action();
    result.fold(
      (failure) =>
          logger.e(loggerErrorMessage, error: failureFactory(Exception())),
      (success) => logger.i(loggerSuccessMessage),
    );
    return result;
  }
}
