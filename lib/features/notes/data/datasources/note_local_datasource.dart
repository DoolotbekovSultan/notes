import 'package:injectable/injectable.dart';
import 'package:note/core/db/app_database.dart';
import 'package:note/features/notes/data/datasources/i_note_local_datasource.dart';
import 'package:note/features/notes/data/models/note_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _isLinierKey = "IS_LINIER";

@LazySingleton(as: INoteLocalDatasource)
class NoteLocalDatasource implements INoteLocalDatasource {
  final AppDatabase _db;
  final SharedPreferences _sP;

  NoteLocalDatasource(this._db, this._sP);

  @override
  Future<List<NoteModel>> getAllNoteModels() {
    return _db.noteDao.getAllNoteModels();
  }

  @override
  Future<void> insertNoteModel(NoteModel noteModel) {
    return _db.noteDao.insertNoteModel(noteModel);
  }

  @override
  Future<NoteModel?> getNoteModelById(int id) {
    return _db.noteDao.getNoteModelById(id);
  }

  @override
  Future<void> deleteNoteModel(NoteModel noteModel) {
    return _db.noteDao.deleteNoteModel(noteModel);
  }

  @override
  Future<List<NoteModel>> searchNoteModels(String query) {
    return _db.noteDao.searchNoteModels(query);
  }

  @override
  Future<bool> getIsLinier() async {
    return _sP.getBool(_isLinierKey) ?? true;
  }

  @override
  Future<void> setIsLinier(bool isLinier) async {
    _sP.setBool(_isLinierKey, isLinier);
  }
}
