// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorLocalDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LocalDatabaseBuilder databaseBuilder(String name) =>
      _$LocalDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$LocalDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$LocalDatabaseBuilder(null);
}

class _$LocalDatabaseBuilder {
  _$LocalDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$LocalDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$LocalDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<LocalDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$LocalDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$LocalDatabase extends LocalDatabase {
  _$LocalDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MovieDao? _movieDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `MovieDatabaseModel` (`id` INTEGER NOT NULL, `original_title` TEXT NOT NULL, `release_date` TEXT, `overview` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MovieDao get movieDao {
    return _movieDaoInstance ??= _$MovieDao(database, changeListener);
  }
}

class _$MovieDao extends MovieDao {
  _$MovieDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _movieDatabaseModelInsertionAdapter = InsertionAdapter(
            database,
            'MovieDatabaseModel',
            (MovieDatabaseModel item) => <String, Object?>{
                  'id': item.id,
                  'original_title': item.original_title,
                  'release_date': item.release_date,
                  'overview': item.overview
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MovieDatabaseModel>
      _movieDatabaseModelInsertionAdapter;

  @override
  Future<List<MovieDatabaseModel>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM MovieDatabaseModel',
        mapper: (Map<String, Object?> row) => MovieDatabaseModel(
            id: row['id'] as int,
            original_title: row['original_title'] as String,
            release_date: row['release_date'] as String?,
            overview: row['overview'] as String?));
  }

  @override
  Future<MovieDatabaseModel?> findMovieById(int id) async {
    return _queryAdapter.query('SELECT * FROM MovieDatabaseModel WHERE id = ?1',
        mapper: (Map<String, Object?> row) => MovieDatabaseModel(
            id: row['id'] as int,
            original_title: row['original_title'] as String,
            release_date: row['release_date'] as String?,
            overview: row['overview'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> insertMovie(MovieDatabaseModel movie) async {
    await _movieDatabaseModelInsertionAdapter.insert(
        movie, OnConflictStrategy.abort);
  }
}
