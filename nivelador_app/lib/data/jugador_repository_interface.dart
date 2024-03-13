import '../models/models.dart';

abstract class IJugadorRepository{
  Future<List<Jugador>> getJugadores();
  Future<void> updateJugador(String id, Jugador jugador);
  Future<void> deleteJugador(String id);
  Future<void> createJugador(Jugador jugador);
}