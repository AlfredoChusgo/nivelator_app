import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main2.dart';

class JugadorDatabase {
  //static final JugadorDatabase _instance = JugadorDatabase._();

  //factory JugadorDatabase() => _instance;

  // static Database _database ;

  // JugadorDatabase._(){
  //   _database = database();
  // };

  static Future<Database> get database async {

    return await _initDatabase();    
  }

  static Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'jugadores.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE jugadores(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT,
            ataque INTEGER,
            defensa INTEGER
          )
          ''',
        );
      },
    );
  }

  static Future<int> insertJugador(Jugador jugador) async {
    final db = await database;
    return await db.insert('jugadores', jugador.toMap());
  }

  static Future<List<Jugador>> getJugadores() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('jugadores');
    return List.generate(maps.length, (i) {
      return Jugador.fromMap(maps[i]);
    });
  }

  static Future<int> updateJugador(Jugador jugador) async {
    final db = await database;
    return await db.update('jugadores', jugador.toMap(),
        where: 'id = ?', whereArgs: [jugador.id]);
  }

  static Future<int> deleteJugador(int id) async {
    final db = await database;
    return await db.delete('jugadores', where: 'id = ?', whereArgs: [id]);
  }
}