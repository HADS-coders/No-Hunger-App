import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {
  static final _dbName = 'nohungerdb.db';
  static final _dbVersion = 1;

  static Database _database;

  static Future<Database> getDatabase() async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  static Future<Database> createDatabase() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Open the database and store the reference.
    final Future<Database> database = openDatabase(
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE vol (name TEXT,email TEXT,number INTEGER,gender TEXT,location TEXT,range INTEGER)');
      },
      version: _dbVersion,
    );
    return database;
  }
}
