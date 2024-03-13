import 'package:nivelador_app/data/list_equipo_repository_interface.dart';

import '../models/models.dart';

class InMemoryListaEquipoRepository extends IListaEquipoRepository {
  @override
  Future<List<ListaEquipoBalanceado>> getListaEquipo() {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteJugador() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveListaEquipo() {
    throw UnimplementedError();
  }
}
