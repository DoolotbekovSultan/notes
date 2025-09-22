import 'package:note/features/notes/data/models/note_model.dart';

abstract class INoteLocalDatasource {
  Future<List<NoteModel>> getAllNotes();
  Future<void> insertNote(NoteModel noteModel);
}
