import 'dart:async';
// ignore: unused_import
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database_name.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE your_table_name (
        id INTEGER PRIMARY KEY,
        name TEXT,
        age INTEGER
      )
    ''');
  }

  Future<int> insert(Map<String, dynamic> row, String tableName) async {
    Database db = await database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await database;
    return await db.query(tableName);
  }
  insertItem(String text) {}
  updateItem(int id, String text) {}
  getItems() {}
  deleteItem(int id) {}
}
