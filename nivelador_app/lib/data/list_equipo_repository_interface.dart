import '../models/models.dart';

abstract class IListaEquipoRepository{
  Future<List<ListaEquipoBalanceado>> getListaEquipo();
  Future<void> saveListaEquipo();
  Future<void> deleteJugador();
}