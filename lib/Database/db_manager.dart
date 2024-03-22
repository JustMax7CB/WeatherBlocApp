import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weather_app/Utils/logger.dart';

@singleton
class DbManager {
  static Database? _appDb;
  static const String _dbName = 'weather_bloc.db';
  static final Logger _logger = Logger(tag: 'DbManager');

  static const tableName = 'weather_table';
  static const columnName = 'city_name';
  static const columnCountry = 'country_name';
  static const columnTempC = 'temp_c';
  static const columnIcon = 'iconUrl';
  static const columnTimestamp = 'timestamp';

  Future<Database> get database async {
    if (_appDb != null) {
      return _appDb!;
    }
    _appDb = await initDatabase();
    return _appDb!;
  }

  Future<Database> initDatabase() async {
    _logger.info('Initializing database..');
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _dbName);

    // Open the database or create if it doesn't exist
    return openDatabase(
      path,
      version: 1,
      onCreate: createDb,
    );
  }

  Future<void> createDb(Database db, int version) async {
    await db.execute('''
    CREATE TABLE $tableName (
    $columnName TEXT PRIMARY KEY,
    $columnCountry TEXT,
    $columnTempC REAL,
    $columnIcon TEXT,
    $columnTimestamp TEXT )''');
  }

  Future<void> insertData(Map<String, dynamic> data) async {
    _logger.info('Inserting data: $data');
    final db = await database;
    await db.insert(tableName, data,conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<void> deleteData(String primaryKeyValue) async {
    _logger.info('Deleting data where primary key value: $primaryKeyValue');

    final db = await database;
    await db.delete(
      tableName,
      where: '$columnName = ?',
      whereArgs: [primaryKeyValue],
    );
  }

  Future<void> updateData(
    Map<String, dynamic> data,
    String primaryKeyValue,
  ) async {
    _logger.info('Updating data: $data');
    final db = await database;
    await db.update(
      tableName,
      data,
      where: '$columnName = ?',
      whereArgs: [primaryKeyValue],
    );
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    _logger.info('Getting all data');
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(tableName);
    return data;
  }

  Future<List<Map<String, dynamic>>> getOneColumnData(String columnKey) async {
    _logger.info('Getting all data from on column with key $columnKey');
    final db = await database;
    final List<Map<String, dynamic>> data = await db.query(tableName, columns: [columnKey]);
    return data;
  }
}
