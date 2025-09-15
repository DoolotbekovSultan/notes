part of 'onboard_cubit.dart';

sealed class OnboardState {}

final class OnboardInitial extends OnboardState {}

final class OnboardShow extends OnboardState {}

final class OnboardSkip extends OnboardState {}

final class OnboardError extends OnboardState {
  final OnboardFailure failure;
  OnboardError(this.failure);
}
