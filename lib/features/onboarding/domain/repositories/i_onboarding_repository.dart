import 'package:dartz/dartz.dart';
import 'package:note/features/onboarding/domain/failure/onboarding_failure.dart';

abstract class IOnboardingRepository {
  Future<Either<ReadOnboardingFailure, bool>> hasSeenOnboarding();
  Future<Either<WriteOnboardingFailure, void>> wasSeenOnboarding();
}
