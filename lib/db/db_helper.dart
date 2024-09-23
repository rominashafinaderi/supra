import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'notes.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
       CREATE TABLE notes(
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       title TEXT,
       content TEXT
       )
       ''');
  }

  //CRUD
//create == add note
  Future<void> addNotes(String title, String content) async {
    Database db = await DatabaseHelper.instance.database;
    await db.insert('notes', {'title': title, 'content': content});
  }

//read
  Future<List<Map<String, dynamic>>> getNote() async {
    Database db = await DatabaseHelper.instance.database;
    return await db.query('notes');
  }

//update
  Future<void> updateNote(int id, String title, String content) async {
    Database db = await DatabaseHelper.instance.database;
    await db.update('notes', {'title': title, 'content': content},
        where: 'id=?', whereArgs: [id]);
  }

//delete
  Future<void> deleteNote(int id) async {
    Database db = await DatabaseHelper.instance.database;
    await db.delete('notes', where: 'id=?', whereArgs: [id]);
  }
}
