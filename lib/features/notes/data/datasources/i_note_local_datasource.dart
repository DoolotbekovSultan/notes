import 'package:note/features/notes/data/models/note_model.dart';

abstract class INoteLocalDatasource {
  Future<List<NoteModel>> getAllNoteModels();
  Future<List<NoteModel>> searchNoteModels(String query);
  Future<void> insertNoteModel(NoteModel noteModel);
  Future<NoteModel?> getNoteModelById(int id);
  Future<void> deleteNoteModel(NoteModel noteModel);
}
