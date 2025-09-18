abstract class OnboardingFailure {
  String get message => "Ошибка Onboarding: ";
  final Exception exception;
  OnboardingFailure(this.exception);

  @override
  String toString() => '"$message" Exception: $exception';
}

class ReadOnboardingFailure extends OnboardingFailure {
  ReadOnboardingFailure(super.exception);

  @override
  String get message => "${super.message}не удалось прочитать.";
}

class WriteOnboardingFailure extends OnboardingFailure {
  WriteOnboardingFailure(super.exception);

  @override
  String get message => "${super.message}не удалось записать.";
}
