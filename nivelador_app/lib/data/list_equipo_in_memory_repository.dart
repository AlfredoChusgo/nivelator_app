import 'package:nivelador_app/data/list_equipo_repository_interface.dart';

import '../models/models.dart';

class InMemoryListaEquipoRepository extends IListaEquipoRepository {
  static List<ListaEquipoBalanceado> _listasEquipoBalanceados = [];

  @override
  Future<List<ListaEquipoBalanceado>> getAllListaEquipo() async {
    Future.delayed(Duration.zero);    
    return List<ListaEquipoBalanceado>.from(_listasEquipoBalanceados);
  }

  @override
  Future<void> deleteListaEquipo(String id) async {
    _listasEquipoBalanceados.removeWhere((listaEquipoBalanceado) => listaEquipoBalanceado.id == id);
  }

  @override
  Future<void> saveListaEquipo(ListaEquipoBalanceado listaEquipoBalanceado) async {
    Future.delayed(Duration.zero);
    _listasEquipoBalanceados.add(listaEquipoBalanceado);
  }
}
