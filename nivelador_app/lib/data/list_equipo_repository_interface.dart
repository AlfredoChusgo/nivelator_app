import '../models/models.dart';

abstract class IListaEquipoRepository{
  Future<List<ListaEquipoBalanceado>> getAllListaEquipo();
  Future<void> saveListaEquipo(ListaEquipoBalanceado listaEquipoBalanceado);
  Future<void> deleteListaEquipo(String id);
}