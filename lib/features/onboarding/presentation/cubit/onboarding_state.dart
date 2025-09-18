part of 'onboarding_cubit.dart';

sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingShow extends OnboardingState {}

final class OnboardingSkip extends OnboardingState {}

final class OnboardingNextButtonClicked extends OnboardingState {}

final class OnboardingSkipTextClicked extends OnboardingState {}

final class OnboardingError extends OnboardingState {
  final OnboardingFailure failure;
  OnboardingError(this.failure);
}

final class OnboardingChangePage extends OnboardingState {
  final int page;
  final bool skipTextVisibility;
  final bool startButtonVisibility;
  OnboardingChangePage({
    required this.page,
    required this.skipTextVisibility,
    required this.startButtonVisibility,
  });
}
