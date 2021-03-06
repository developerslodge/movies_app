// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  MoviesDao? _moviesDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 11,
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
            'CREATE TABLE IF NOT EXISTS `movies` (`id` INTEGER, `title` TEXT, `originalLanguage` TEXT, `originalTitle` TEXT, `overview` TEXT, `video` INTEGER, `popularity` REAL, `posterPath` TEXT, `releaseDate` TEXT, `voteAverage` REAL, `voteCount` INTEGER, `backdropPath` TEXT, `adult` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MoviesDao get moviesDao {
    return _moviesDaoInstance ??= _$MoviesDao(database, changeListener);
  }
}

class _$MoviesDao extends MoviesDao {
  _$MoviesDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _moviesInsertionAdapter = InsertionAdapter(
            database,
            'movies',
            (Movies item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'originalLanguage': item.originalLanguage,
                  'originalTitle': item.originalTitle,
                  'overview': item.overview,
                  'video': item.video == null ? null : (item.video! ? 1 : 0),
                  'popularity': item.popularity,
                  'posterPath': item.posterPath,
                  'releaseDate': item.releaseDate,
                  'voteAverage': item.voteAverage,
                  'voteCount': item.voteCount,
                  'backdropPath': item.backdropPath,
                  'adult': item.adult == null ? null : (item.adult! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Movies> _moviesInsertionAdapter;

  @override
  Future<List<Movies>> findAllMovies() async {
    return _queryAdapter.queryList('SELECT * FROM movies',
        mapper: (Map<String, Object?> row) => Movies(
            id: row['id'] as int?,
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            originalTitle: row['originalTitle'] as String?,
            originalLanguage: row['originalLanguage'] as String?,
            popularity: row['popularity'] as double?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            overview: row['overview'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?,
            backdropPath: row['backdropPath'] as String?));
  }

  @override
  Future<Movies?> findMovieWithId(int id) async {
    return _queryAdapter.query('SELECT * FROM movies where id = ?1',
        mapper: (Map<String, Object?> row) => Movies(
            id: row['id'] as int?,
            adult: row['adult'] == null ? null : (row['adult'] as int) != 0,
            originalTitle: row['originalTitle'] as String?,
            originalLanguage: row['originalLanguage'] as String?,
            popularity: row['popularity'] as double?,
            posterPath: row['posterPath'] as String?,
            releaseDate: row['releaseDate'] as String?,
            overview: row['overview'] as String?,
            video: row['video'] == null ? null : (row['video'] as int) != 0,
            voteAverage: row['voteAverage'] as double?,
            voteCount: row['voteCount'] as int?,
            backdropPath: row['backdropPath'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteMovie(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from movies where id = ?1', arguments: [id]);
  }

  @override
  Future<void> deleteAll() async {
    await _queryAdapter.queryNoReturn('delete from movies');
  }

  @override
  Future<void> insertMovie(Movies movie) async {
    await _moviesInsertionAdapter.insert(movie, OnConflictStrategy.replace);
  }

  @override
  Future<List<int>> insertAllMovies(List<Movies> brands) {
    return _moviesInsertionAdapter.insertListAndReturnIds(
        brands, OnConflictStrategy.replace);
  }
}
