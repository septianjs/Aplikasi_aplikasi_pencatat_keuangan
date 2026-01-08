import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaksi.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transaksi.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transaksi(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nama TEXT NOT NULL,
            tanggal TEXT NOT NULL,
            nominal REAL NOT NULL,
            isIncome INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  // INSERT transaksi
  Future<int> insertTransaksi(Transaksi transaksi) async {
    final db = await database;
    return await db.insert('transaksi', transaksi.toMap());
  }

  // GET ALL transaksi
  Future<List<Transaksi>> getAllTransaksi() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transaksi');
    
    return List.generate(maps.length, (i) {
      return Transaksi.fromMap(maps[i]);
    });
  }

  // UPDATE transaksi
  Future<int> updateTransaksi(Transaksi transaksi) async {
    final db = await database;
    return await db.update(
      'transaksi',
      transaksi.toMap(),
      where: 'id = ?',
      whereArgs: [transaksi.id],
    );
  }

  // DELETE transaksi
  Future<int> deleteTransaksi(int id) async {
    final db = await database;
    return await db.delete(
      'transaksi',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // DELETE ALL (untuk reset)
  Future<void> deleteAllTransaksi() async {
    final db = await database;
    await db.delete('transaksi');
  }
}