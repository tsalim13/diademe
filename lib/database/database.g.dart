// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

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

  SalerDao? _salerDaoInstance;

  SalerReviewDao? _salerReviewDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `Saler` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `phone` TEXT NOT NULL, `birthday` TEXT NOT NULL, `startday` TEXT NOT NULL, `actif` INTEGER NOT NULL, `image` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `saler_review` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `saler_id` INTEGER NOT NULL, `mark` INTEGER NOT NULL, `comment` TEXT NOT NULL, `date` INTEGER NOT NULL, FOREIGN KEY (`saler_id`) REFERENCES `Saler` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SalerDao get salerDao {
    return _salerDaoInstance ??= _$SalerDao(database, changeListener);
  }

  @override
  SalerReviewDao get salerReviewDao {
    return _salerReviewDaoInstance ??=
        _$SalerReviewDao(database, changeListener);
  }
}

class _$SalerDao extends SalerDao {
  _$SalerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _salerInsertionAdapter = InsertionAdapter(
            database,
            'Saler',
            (Saler item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone,
                  'birthday': item.birthday,
                  'startday': item.startday,
                  'actif': item.actif ? 1 : 0,
                  'image': item.image
                }),
        _salerUpdateAdapter = UpdateAdapter(
            database,
            'Saler',
            ['id'],
            (Saler item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone,
                  'birthday': item.birthday,
                  'startday': item.startday,
                  'actif': item.actif ? 1 : 0,
                  'image': item.image
                }),
        _salerDeletionAdapter = DeletionAdapter(
            database,
            'Saler',
            ['id'],
            (Saler item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'phone': item.phone,
                  'birthday': item.birthday,
                  'startday': item.startday,
                  'actif': item.actif ? 1 : 0,
                  'image': item.image
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Saler> _salerInsertionAdapter;

  final UpdateAdapter<Saler> _salerUpdateAdapter;

  final DeletionAdapter<Saler> _salerDeletionAdapter;

  @override
  Future<List<Saler>> findAllSalers() async {
    return _queryAdapter.queryList('SELECT * FROM Saler',
        mapper: (Map<String, Object?> row) => Saler(
            id: row['id'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String,
            birthday: row['birthday'] as String,
            startday: row['startday'] as String,
            actif: (row['actif'] as int) != 0,
            image: row['image'] as String));
  }

  @override
  Future<List<Saler>> findAllActifSalers() async {
    return _queryAdapter.queryList('SELECT * FROM Saler WHERE actif = 1',
        mapper: (Map<String, Object?> row) => Saler(
            id: row['id'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String,
            birthday: row['birthday'] as String,
            startday: row['startday'] as String,
            actif: (row['actif'] as int) != 0,
            image: row['image'] as String));
  }

  @override
  Future<Saler?> findSalerById(int id) async {
    return _queryAdapter.query('SELECT * FROM Saler WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Saler(
            id: row['id'] as int?,
            name: row['name'] as String,
            phone: row['phone'] as String,
            birthday: row['birthday'] as String,
            startday: row['startday'] as String,
            actif: (row['actif'] as int) != 0,
            image: row['image'] as String),
        arguments: [id]);
  }

  @override
  Future<void> insertSaler(Saler saler) async {
    await _salerInsertionAdapter.insert(saler, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSaler(Saler saler) async {
    await _salerUpdateAdapter.update(saler, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSaler(Saler saler) async {
    await _salerDeletionAdapter.delete(saler);
  }
}

class _$SalerReviewDao extends SalerReviewDao {
  _$SalerReviewDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _salerReviewInsertionAdapter = InsertionAdapter(
            database,
            'saler_review',
            (SalerReview item) => <String, Object?>{
                  'id': item.id,
                  'saler_id': item.salerId,
                  'mark': item.mark,
                  'comment': item.comment,
                  'date': item.date
                }),
        _salerReviewUpdateAdapter = UpdateAdapter(
            database,
            'saler_review',
            ['id'],
            (SalerReview item) => <String, Object?>{
                  'id': item.id,
                  'saler_id': item.salerId,
                  'mark': item.mark,
                  'comment': item.comment,
                  'date': item.date
                }),
        _salerReviewDeletionAdapter = DeletionAdapter(
            database,
            'saler_review',
            ['id'],
            (SalerReview item) => <String, Object?>{
                  'id': item.id,
                  'saler_id': item.salerId,
                  'mark': item.mark,
                  'comment': item.comment,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SalerReview> _salerReviewInsertionAdapter;

  final UpdateAdapter<SalerReview> _salerReviewUpdateAdapter;

  final DeletionAdapter<SalerReview> _salerReviewDeletionAdapter;

  @override
  Future<List<SalerReview>> findAllSalerReviews() async {
    return _queryAdapter.queryList('SELECT * FROM saler_review',
        mapper: (Map<String, Object?> row) => SalerReview(
            id: row['id'] as int?,
            salerId: row['saler_id'] as int,
            mark: row['mark'] as int,
            comment: row['comment'] as String,
            date: row['date'] as int));
  }

  @override
  Future<SalerReview?> findSalerReviewById(int id) async {
    return _queryAdapter.query('SELECT * FROM saler_review WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SalerReview(
            id: row['id'] as int?,
            salerId: row['saler_id'] as int,
            mark: row['mark'] as int,
            comment: row['comment'] as String,
            date: row['date'] as int),
        arguments: [id]);
  }

  @override
  Future<List<SalerReview>> findSalerReviewBySalerIdDateRange(
      List<int> ids, int start, int end) async {
    const offset = 3;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'SELECT * FROM saler_review WHERE saler_id IN (' +
            _sqliteVariablesForIds +
            ') AND date BETWEEN ?1 AND ?2',
        mapper: (Map<String, Object?> row) => SalerReview(
            id: row['id'] as int?,
            salerId: row['saler_id'] as int,
            mark: row['mark'] as int,
            comment: row['comment'] as String,
            date: row['date'] as int),
        arguments: [start, end, ...ids]);
  }

  @override
  Future<void> insertSalerReview(SalerReview salerReview) async {
    await _salerReviewInsertionAdapter.insert(
        salerReview, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSalerReview(SalerReview salerReview) async {
    await _salerReviewUpdateAdapter.update(
        salerReview, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSalerReview(SalerReview salerReview) async {
    await _salerReviewDeletionAdapter.delete(salerReview);
  }
}
