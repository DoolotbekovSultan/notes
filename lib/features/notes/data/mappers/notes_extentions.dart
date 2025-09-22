import 'package:note/features/notes/data/models/note_model.dart';
import 'package:note/features/notes/domain/entities/note.dart';

extension NoteModelExtentions on NoteModel {
  Note toDomain() =>
      Note(title: title, description: description, dateTime: dateTime);
}

extension NoteModelsExtentions on List<NoteModel> {
  List<Note> toDomains() => map((model) => model.toDomain()).toList();
}

extension NoteExtentions on Note {
  NoteModel toModel() => NoteModel(
    id: id,
    title: title,
    description: description,
    dateTime: dateTime,
    color: color,
  );
}
