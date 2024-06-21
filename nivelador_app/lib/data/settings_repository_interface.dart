

import 'package:nivelador_app/models/models.dart';

abstract class ISettingsRepository{
  Future<Settings> getSettings();
  Future<void> updateSettings(Settings jugador);
}