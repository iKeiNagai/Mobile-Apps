import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  static final table = 'settings';
  static final column1 = 'id';
  static final column2 = 'fish';
  static final column3 = 'speed';
  static final column4 = 'color';

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('aquarium_settings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $table (
      $column1 INTEGER PRIMARY KEY AUTOINCREMENT,
      $column2 INTEGER,
      $column3 REAL,
      $column4 INTEGER
    )
    ''');
  }

  Future<int> saveSettings(int fish, double speed, int colorValue) async {
    final db = await instance.database;

    return await db.insert(table, {
      column2: fish,
      column3: speed,
      column4: colorValue,
    });
  }

  Future<List<Map<String, dynamic>>> loadSettings() async {
    final db = await instance.database;
    return await db.query(table);

  }

  Future<int> deleteSettings()async{
    final db = await instance.database;

    return await db.delete(table);
  }
}
