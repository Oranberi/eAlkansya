import 'package:ealkansyaapp/services/pin.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    String sql =
        "CREATE TABLE pinKey(id INTEGER PRIMARY KEY AUTOINCREMENT, pin INTEGER NOT NULL)";
    return openDatabase(join(path, 'pinKey.db'),
        onCreate: (database, version) async {
      await database.execute(sql);
    }, version: 1);
  }

  Future<int> createItem(String pin) async {
    final Database db = await initDB();
    return await db.insert('pinKey', {'pin': pin});
  }

  Future<String?> getPin() async {
    final Database db = await initDB();
    List<Map> list = await db.rawQuery("SELECT * FROM pinKey");
    if (list.length > 0) {
      return list[0]["pin"]?.toString();
    }
    return null;
  }

  Future<int> updatePin(String newPin) async {
    final Database db = await initDB();

    return await db.update('pinKey', {'pin': newPin},
        where: "id = ?", whereArgs: [1]);
  }
}
