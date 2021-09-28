import 'package:restauran_app/data/model/list_restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tableFavorite = 'favorites';
  static const String _databaseName = 'restaurantapp.db';
  static const int _databaseVersion = 1;

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db =
        openDatabase('$path/$_databaseName', onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $_tableFavorite (
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT, 
      pictureId TEXT, 
      city TEXT, 
      city DOUBLE, 
      )''');
    }, version: _databaseVersion);

    return db;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initializeDb();
    }

    return _database;
  }

  Future<void> insertFavorite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableFavorite, restaurant.toJson());
  }

  Future<List<Restaurant>> getFavorites() async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(_tableFavorite);

    return results.map((result) => Restaurant.fromJson(result)).toList();
  }

  Future<Map> getFavoriteRestaurantById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
