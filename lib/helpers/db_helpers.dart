import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DbHelper {
  static Future<Database> database() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
      return db.execute('CREATE TABLE userPlaces(id TEXT PRIMARY KEY,'
          ' title TEXT, image TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
    final db = await DbHelper.database();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<void> deleteItem(String table, String id) async {
    final db = await DbHelper.database();
    db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbHelper.database();
    return db.query(table);
  }
}
