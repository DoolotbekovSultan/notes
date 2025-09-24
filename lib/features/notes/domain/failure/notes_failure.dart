abstract class NotesFailure {
  String get message => "Ошибка Notes: ";
  final Exception exception;
  NotesFailure(this.exception);

  @override
  String toString() => '"$message" Exception: $exception';
}

class LoadAllNotesFailure extends NotesFailure {
  LoadAllNotesFailure(super.exception);

  @override
  String get message => "${super.message}не удалось получить notes.";
}

class LoadNoteFailure extends NotesFailure {
  LoadNoteFailure(super.exception);

  @override
  String get message => "${super.message}не удалось получить note.";
}

class InsertNoteFailure extends NotesFailure {
  InsertNoteFailure(super.exception);

  @override
  String get message => "${super.message}не удалось добавть note.";
}
