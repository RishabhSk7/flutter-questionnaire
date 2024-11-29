import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('questions.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE questions (
      question TEXT PRIMARY KEY
    )
    ''');
  }

  Future<int> insertQuestion(String question) async {
    final db = await instance.database;
    // Since question is the primary key, insert will replace any existing question with the same value.
    return await db.insert('questions', {'question': question},
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getQuestions() async {
    final db = await instance.database;
    return await db.query('questions');
  }

  Future<int> deleteQuestion(String question) async {
    final db = await instance.database;
    return await db
        .delete('questions', where: 'question = ?', whereArgs: [question]);
  }
}
