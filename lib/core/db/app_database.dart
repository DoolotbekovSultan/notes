import 'package:floor/floor.dart';
import 'package:note/core/db/dao/note_dao.dart';
import 'package:note/features/notes/data/models/note_model.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'package:note/features/notes/utils/type_coverters/color_converter.dart';
import 'package:note/features/notes/utils/type_coverters/date_time_converter.dart';

part 'app_database.g.dart';

@Database(version: 1, entities: [NoteModel])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}
