

import 'package:nivelador_app/business_logic/database_helper.dart';
import 'package:nivelador_app/data/jugador_repository_interface.dart';
import 'package:nivelador_app/data/list_equipo_repository_interface.dart';
import 'package:nivelador_app/data/settings_repository_interface.dart';
import 'package:nivelador_app/models/models.dart';

class SQLiteSettingsRepository implements ISettingsRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper();


  @override
  Future<Settings> getSettings() async {
    return await _databaseHelper.getSettings();
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    await _databaseHelper.updateSettings(settings);
  }
  
}

