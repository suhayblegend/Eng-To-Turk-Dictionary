import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'vocabulary.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE words(id INTEGER PRIMARY KEY, name TEXT, mean TEXT)",
        );
      },
    );
  }

  Future<void> insertWord(Map<String, dynamic> word) async {
    final Database db = await database;
    await db.insert('words', word, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getWords() async {
    final Database db = await database;
    return await db.query('words');
  }
}

 Future<void> updateWord(Map<String, dynamic> word) async {
    var database;
    final Database db = await database;
    await db.update(
      'words',
      word,
      where: "id = ?",
      whereArgs: [word['id']],
    );
  }
