import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'audiobooks.db');

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute(
      '''
        CREATE TABLE audiobooks (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          description TEXT NOT NULL,
          url_text_source TEXT NOT NULL,
          language TEXT NOT NULL,
          copyright_year TEXT NOT NULL,
          num_sections TEXT NOT NULL,
          url_rss TEXT NOT NULL,
          url_zip_file TEXT NOT NULL,
          url_project TEXT NOT NULL,
          url_librivox TEXT NOT NULL,
          url_other TEXT NOT NULL,
          totaltime TEXT NOT NULL,
          totaltimesecs INTEGER NOT NULL,
          authors TEXT NOT NULL,
          rssFeed TEXT
        )
      ''',
    );

    await db.execute(
      '''
        CREATE TABLE authors (
          id TEXT,
          first_name TEXT,
          last_name TEXT,
          dob TEXT,
          dod TEXT
        )
      ''',
    );
  }

  Future<void> insert(String tableName, Map<String, dynamic> model) async {
    final db = await instance.database;
    await db.insert(
      tableName,
      model,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getAll(String tableName) async {
    final db = await instance.database;
    return await db.query(tableName);
  }

  Future<void> updateByQuery(
    String tableName,
    Map<String, dynamic> model,
    List<Object> whereArgs,
  ) async {
    final db = await instance.database;
    await db.update(
      tableName,
      model,
      where: 'id = ?',
      whereArgs: whereArgs,
    );
  }

  Future<void> deleteByQuery(
    String tableName,
    List<Object> whereArgs,
  ) async {
    final db = await instance.database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: whereArgs,
    );
  }

  Future<void> deleteAll(String tableName) async {
    final db = await instance.database;
    await db.delete(tableName);
  }
}
