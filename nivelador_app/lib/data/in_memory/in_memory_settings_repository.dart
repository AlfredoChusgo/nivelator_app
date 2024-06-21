

import 'package:nivelador_app/business_logic/database_helper.dart';
import 'package:nivelador_app/data/jugador_repository_interface.dart';
import 'package:nivelador_app/data/list_equipo_repository_interface.dart';
import 'package:nivelador_app/data/settings_repository_interface.dart';
import 'package:nivelador_app/models/models.dart';

class InMemorySettingsRepository implements ISettingsRepository {
  static Settings _settings = Settings.defaultSettings();  


  @override
  Future<Settings> getSettings() async {
    return _settings;
  }

  @override
  Future<void> updateSettings(Settings settings) async {
    _settings = settings;
  }
  
}

