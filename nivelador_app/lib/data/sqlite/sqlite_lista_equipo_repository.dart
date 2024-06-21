

import 'package:nivelador_app/business_logic/database_helper.dart';
import 'package:nivelador_app/data/list_equipo_repository_interface.dart';
import 'package:nivelador_app/models/models.dart';

class ListaEquipoRepository implements IListaEquipoRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  Future<List<ListaEquipoBalanceado>> getAllListaEquipo() async {
    final db = await _databaseHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('equipos');
    return List.generate(maps.length, (i) {
      return ListaEquipoBalanceado(
        id: maps[i]['id'],
        nombre: maps[i]['nombre'],
        dateTime: DateTime.parse(maps[i]['dateTime']),
        equipos: [], // You'll need to fetch teams for each ListaEquipoBalanceado separately
      );
    });
  }

  @override
  Future<void> saveListaEquipo(ListaEquipoBalanceado listaEquipoBalanceado) async {
    final db = await _databaseHelper.database;
    await db.insert('equipos', listaEquipoBalanceado.toMap());
    // Save teams associated with this listaEquipoBalanceado as well
    // You would typically have a separate table for teams and a join table for teams and listaEquipoBalanceado
    // Implement logic for saving teams based on your database schema
  }

  @override
  Future<void> deleteListaEquipo(String id) async {
    final db = await _databaseHelper.database;
    await db.delete(
      'equipos',
      where: "id = ?",
      whereArgs: [id],
    );
    // Also delete associated teams and their mappings from join table
  }
}
