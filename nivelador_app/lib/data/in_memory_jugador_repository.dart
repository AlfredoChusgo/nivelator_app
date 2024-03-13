import 'package:nivelador_app/data/jugador_repository_interface.dart';
import 'package:nivelador_app/models/models.dart';

import 'fake_data/fake_jugadores.dart';

class InMemoryJugadorRepository extends IJugadorRepository{
  static List<Jugador> _jugadores = [];
  
  InMemoryJugadorRepository(){
    if(_jugadores.isEmpty){
      _jugadores = fakeJugadores;
    }
  }

  @override
  Future<void> createJugador(Jugador jugador) async {
     Future.delayed(Duration.zero);
    _jugadores.add(jugador);
  }
  
  @override
  Future<void> deleteJugador(String id) async {
    _jugadores.removeWhere((jugador) => jugador.id == id);
  }
  
  @override
  Future<List<Jugador>> getJugadores() async {
    return List<Jugador>.from(_jugadores);
  }
  
  @override
  Future<void> updateJugador(String id, Jugador jugador) async {
    int index = _jugadores.indexWhere((jugador) => jugador.id == id);
    if (index != -1) {
      _jugadores[index] = jugador;
    } else {
      throw Exception('Jugador with id $id not found');
    }
  }


}