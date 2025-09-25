// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  NoteDao? _noteDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoteModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `dateTime` INTEGER NOT NULL, `color` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NoteDao get noteDao {
    return _noteDaoInstance ??= _$NoteDao(database, changeListener);
  }
}

class _$NoteDao extends NoteDao {
  _$NoteDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _noteModelInsertionAdapter = InsertionAdapter(
            database,
            'NoteModel',
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'color': _colorConverter.encode(item.color)
                }),
        _noteModelDeletionAdapter = DeletionAdapter(
            database,
            'NoteModel',
            ['id'],
            (NoteModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'dateTime': _dateTimeConverter.encode(item.dateTime),
                  'color': _colorConverter.encode(item.color)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoteModel> _noteModelInsertionAdapter;

  final DeletionAdapter<NoteModel> _noteModelDeletionAdapter;

  @override
  Future<List<NoteModel>> getAllNoteModels() async {
    return _queryAdapter.queryList('SELECT * FROM NoteModel',
        mapper: (Map<String, Object?> row) => NoteModel(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int),
            color: _colorConverter.decode(row['color'] as int)));
  }

  @override
  Future<NoteModel?> getNoteModelById(int id) async {
    return _queryAdapter.query('SELECT * FROM NoteModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => NoteModel(
            id: row['id'] as int?,
            title: row['title'] as String,
            description: row['description'] as String,
            dateTime: _dateTimeConverter.decode(row['dateTime'] as int),
            color: _colorConverter.decode(row['color'] as int)),
        arguments: [id]);
  }

  @override
  Future<List<NoteModel>> searchNoteModels(String query) async {
    return _queryAdapter.queryList(
        'SELECT * FROM NoteModel     WHERE title LIKE \'%\' || ?1 || \'%\'       OR description LIKE \'%\' || ?1 || \'%\'',
        mapper: (Map<String, Object?> row) => NoteModel(id: row['id'] as int?, title: row['title'] as String, description: row['description'] as String, dateTime: _dateTimeConverter.decode(row['dateTime'] as int), color: _colorConverter.decode(row['color'] as int)),
        arguments: [query]);
  }

  @override
  Future<void> insertNoteModel(NoteModel noteModel) async {
    await _noteModelInsertionAdapter.insert(
        noteModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteNoteModel(NoteModel noteModel) async {
    await _noteModelDeletionAdapter.delete(noteModel);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _colorConverter = ColorConverter();
