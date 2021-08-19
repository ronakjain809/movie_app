import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'movies_list.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE list_movies(id TEXT PRIMARY KEY,title TEXT,image TEXT, director TEXT)');
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    // final database = sql
    //     .openDatabase(path.join(await sql.getDatabasesPath(), 'movie_list.db'));
    // final db = await database;
    return db.query(table);
  }

  static Future<void> delete(String table, String titleSelected) async {
    final db = await DBHelper.database();
    db.execute('DELETE FROM $table WHERE title = \'$titleSelected\'');
  }

  static Future<void> update(String table, Map<String, Object> updates, Map<String, Object> where) async {
    final db = await DBHelper.database();
    final valuesToSet = updates.entries.map((e) => e.key +"=" + e.value).join(", ");
    final conditions =  where.entries.map((e) => e.key +"=" + e.value).join(" AND ");
    db.execute('UPDATE $table SET $valuesToSet WHERE $conditions');
  }
}
