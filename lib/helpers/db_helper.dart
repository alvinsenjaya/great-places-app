import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<sql.Database> database(String table) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $table(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_latitude REAL, loc_longitude REAL, loc_address TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> insert(
    String table,
    Map<String, Object> data,
  ) async {
    final database = await DbHelper.database(table);

    await database.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<void> deleteById(
    String table,
    String id,
  ) async {
    final database = await DbHelper.database(table);

    await database.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<Map<String, Object>>> getData(
    String table,
  ) async {
    final database = await DbHelper.database(table);

    return database.query(table);
  }
}
