abstract class OnboardFailure {
  String get message => "Ошибка Onboard: ";
  final Exception exception;
  OnboardFailure(this.exception);

  @override
  String toString() => '"$message" Exception: $exception';
}

class ReadOnboardFailure extends OnboardFailure {
  ReadOnboardFailure(super.exception);

  @override
  String get message => "${super.message}не удалось прочитать.";
}

class WriteOnboardFailure extends OnboardFailure {
  WriteOnboardFailure(super.exception);

  @override
  String get message => "${super.message}не удалось записать.";
}
