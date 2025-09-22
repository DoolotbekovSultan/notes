import 'package:floor/floor.dart';
import 'package:note/features/notes/data/models/note_model.dart';

@dao
abstract class NoteDao {
  @Query("SELECT * FROM NoteModel")
  Future<List<NoteModel>> getAllNoteModels();

  @insert
  Future<void> insertNoteModel(NoteModel noteModel);
}
