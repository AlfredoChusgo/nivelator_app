

import 'package:nivelador_app/business_logic/database_helper.dart';
import 'package:nivelador_app/data/fake_data/fake_jugadores.dart';
import 'package:nivelador_app/data/jugador_repository_interface.dart';
import 'package:nivelador_app/data/list_equipo_repository_interface.dart';
import 'package:nivelador_app/models/models.dart';

class JugadorRepository implements IJugadorRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<void> createJugador(Jugador jugador) async {
    await _databaseHelper.createJugador(jugador);
  }

  @override
  Future<List<Jugador>> getJugadores() async {
    return await _databaseHelper.getJugadores();
  }

  @override
  Future<void> updateJugador(String id, Jugador jugador) async {
    await _databaseHelper.updateJugador(id,jugador);
  }

  @override
  Future<void> deleteJugador(String id) async {
    await _databaseHelper.deleteJugador(id);
  }
  
  @override
  Future<void> restoreDefaultValues() async {
    // TODO: implement restoreDefaultValues
    await _databaseHelper.emptyJugadoresTable();
    fakeJugadores.forEach((element) async { 
      await createJugador(element);
    });
  }
  
  @override
  Future<void> emptyJuguadores() async {
    await _databaseHelper.emptyJugadoresTable();
  }
  
  @override
  Future<void> createJugadores(List<Jugador> jugadores) async {
    jugadores.forEach((element) async { 
      await createJugador(element);
    });
  }
}

