import 'package:injectable/injectable.dart';
import 'package:note/core/db/app_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();
  @preResolve
  Future<AppDatabase> get database async =>
      await $FloorAppDatabase.databaseBuilder("notes.db").build();
}
