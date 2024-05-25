import 'dart:async';
import 'package:nivelador_app/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._privateConstructor();

  factory DatabaseHelper() {
    if (_instance == null) {
      _instance = DatabaseHelper._privateConstructor();
    }
    return _instance!;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'your_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS jugadores (
        id TEXT PRIMARY KEY,
        nombre TEXT,
        ataque REAL,
        defensa REAL,
        salvada REAL,
        servida REAL,
        teamplay REAL,
        saque REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS equipos (
        id TEXT PRIMARY KEY,
        nombre TEXT,
        dateTime TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS equipos_jugadores (
        equipo_id TEXT,
        jugador_id TEXT,
        FOREIGN KEY (equipo_id) REFERENCES equipos (id),
        FOREIGN KEY (jugador_id) REFERENCES jugadores (id)
      )
    ''');


    await db.execute('''
      CREATE TABLE IF NOT EXISTS listas (
        id TEXT PRIMARY KEY,
        nombre TEXT,
        dateTime TEXT,        
      )
    ''');


    await db.execute('''
      CREATE TABLE IF NOT EXISTS lista_jugadores (
        id TEXT PRIMARY KEY,
        nombre TEXT,
        dateTime TEXT,
        FOREIGN KEY (lista_id) REFERENCES listas (id),
        FOREIGN KEY (jugador_id) REFERENCES jugadores (id)
      )
    ''');
  }

  Future<void> createJugador(Jugador jugador) async {
    final db = await database;
    await db.insert('jugadores', jugador.toSqliteTable());
  }

  Future<List<Jugador>> getJugadores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('jugadores');
    return List.generate(maps.length, (i) {
      return Jugador.fromSQLiteTable(maps[i]);
    });
  }

    Future<void> updateJugador(String id, Jugador jugador) async {
    final db = await database;
    await db.update(
      'jugadores',
      jugador.toSqliteTable(),
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<void> deleteJugador(String id) async {
    final db = await database;
    await db.delete(
      'jugadores',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  
  Future<void> emptyJugadoresTable() async {
    final db = await database;
    await db.execute("DELETE FROM Jugadores");
  }


  //   Future<void> createListaJugadores(ListaJugadores lista) async {
  //   final db = await database;
  //   await db.insert('jugadores', jugador.toSqliteTable());
  // }

  // Future<List<Jugador>> getJugadores() async {
  //   final db = await database;
  //   final List<Map<String, dynamic>> maps = await db.query('jugadores');
  //   return List.generate(maps.length, (i) {
  //     return Jugador.fromSQLiteTable(maps[i]);
  //   });
  // }

  //   Future<void> updateJugador(String id, Jugador jugador) async {
  //   final db = await database;
  //   await db.update(
  //     'jugadores',
  //     jugador.toSqliteTable(),
  //     where: "id = ?",
  //     whereArgs: [id],
  //   );
  // }

  // Future<void> deleteJugador(String id) async {
  //   final db = await database;
  //   await db.delete(
  //     'jugadores',
  //     where: "id = ?",
  //     whereArgs: [id],
  //   );
  // }

  // Implement other CRUD methods for Jugador and Equipo here
}
