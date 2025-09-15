import 'package:dartz/dartz.dart';
import 'package:note/features/onboard/domain/failure/onboard_failure.dart';

abstract class IOnboardRepository {
  Future<Either<ReadOnboardFailure, bool>> hasSeenOnboard();
  Future<Either<WriteOnboardFailure, void>> wasSeenOnboard();
}
