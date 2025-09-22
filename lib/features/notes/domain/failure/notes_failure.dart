abstract class NotesFailure {
  String get message => "Ошибка Notes: ";
  final Exception exception;
  NotesFailure(this.exception);

  @override
  String toString() => '"$message" Exception: $exception';
}

class GetAllNotesFailure extends NotesFailure {
  GetAllNotesFailure(super.exception);

  @override
  String get message => "${super.message}не удалось прочитать.";
}

class InsertNoteFailure extends NotesFailure {
  InsertNoteFailure(super.exception);

  @override
  String get message => "${super.message}не удалось записать.";
}
