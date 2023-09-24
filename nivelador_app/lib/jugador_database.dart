import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'main2.dart';
import 'models/models.dart';

class JugadorDatabase {
  //static final JugadorDatabase _instance = JugadorDatabase._();

  //factory JugadorDatabase() => _instance;

  // static Database database ;

  // JugadorDatabase._(){
  //   database = database();
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
        db.execute(
          '''
          CREATE TABLE jugadores(
            id TEXT PRIMARY KEY,
            nombre TEXT,
            ataque INTEGER,
            defensa INTEGER
          )
          ''',
        );

         db.execute('''
          CREATE TABLE lista_equipo_balanceado (
            id TEXT PRIMARY KEY,
            nombre TEXT,
            grupos TEXT
          )
        ''');       

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

  static Future<int> deleteJugador(String id) async {
    final db = await database;
    return await db.delete('jugadores', where: 'id = ?', whereArgs: [id]);
  }
////////////////

 Future<void> insertListaEquipoBalanceado(ListaEquipoBalanceado lista) async {
    await (await database).insert('lista_equipo_balanceado', lista.toMap());
  }

Future<List<ListaEquipoBalanceado>> getAllListaEquipoBalanceado() async {
    final List<Map<String, dynamic>> maps = await (await database).query('lista_equipo_balanceado');
    return List.generate(maps.length, (i) {
      return ListaEquipoBalanceado.fromMap(maps[i]);
    });
  }

  Future<void> updateListaEquipoBalanceado(ListaEquipoBalanceado lista) async {
    await (await database).update(
      'lista_equipo_balanceado',
      lista.toMap(),
      where: 'id = ?',
      whereArgs: [lista.id],
    );
  }

  Future<void> deleteListaEquipoBalanceado(String id) async {
    await (await database).delete(
      'lista_equipo_balanceado',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
  ///
}