import 'package:floor/floor.dart';
import 'package:note/features/notes/data/models/note_model.dart';

@dao
abstract class NoteDao {
  @Query("SELECT * FROM NoteModel")
  Future<List<NoteModel>> getAllNoteModels();

  @Query("SELECT * FROM NoteModel WHERE id = :id")
  Future<NoteModel?> getNoteModelById(int id);

  @Query("""
    SELECT * FROM NoteModel
    WHERE title LIKE '%' || :query || '%'
      OR description LIKE '%' || :query || '%'
  """)
  Future<List<NoteModel>> searchNoteModels(String query);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertNoteModel(NoteModel noteModel);
}
