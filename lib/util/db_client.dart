import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:listis/model/listis_item.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;

  final String tableName = "listisTbl";
  final String columnID = "id";
  final String columnItemName = "itemName";
  final String columnDateCreated = "dateCreated";

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;

    _db = await initDB();
    return _db;
  }

  DatabaseHelper.internal();

  initDB() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    String path = join(docDir.path, "listis.db");
    var oDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return oDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableName(id INTEGER PRIMARY KEY, $columnItemName TEXT, $columnDateCreated TEXT)");

    print("Table has been created");
  }

  Future<int> saveItem(ListisItem item) async {
    var dbClient = await db;
    int res = await dbClient.insert("$tableName", item.toMap());
    print(res.toString());
    return res;
  }

  Future<List> getItems() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName ORDER BY $columnItemName ASC");
    return result.toList();
  }

  Future<int> getCount() async {
    var dbClient = await db;

    return Sqflite.firstIntValue(await dbClient.rawQuery("SELECT COUNT(*) FROM $tableName"));
  }

  Future<ListisItem> getItem(int id) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableName WHERE id = $id");
    if (result.length == 0) return null;
    return ListisItem.fromMap(result.first);
  }

  Future<int> deleteItem(int id) async {
    var dbClient = await db;
    return await dbClient.delete("$tableName", where: "$columnID = ?", whereArgs: [id]);
  }

  Future<int> updateItem(ListisItem item) async {
    var dbClient = await db;
    return await dbClient.update("$tableName", item.toMap(), where: "$columnID = ?", whereArgs: [item.id]);
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}