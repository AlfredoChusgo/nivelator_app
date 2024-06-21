import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/listas_guardadas/bloc/listas_guardadas_bloc.dart';
import 'package:nivelador_app/bloc/settings/settings_bloc.dart';
import 'package:nivelador_app/data/in_memory_jugador_repository.dart';
import 'package:nivelador_app/data/jugador_repository_interface.dart';
import 'package:nivelador_app/data/list_equipo_in_memory_repository.dart';
import 'package:nivelador_app/data/settings_repository_interface.dart';
import 'package:nivelador_app/data/sqlite_jugador_repository.dart';
import 'package:nivelador_app/data/sqlite_lista_equipo_repository.dart';
import 'package:nivelador_app/data/sqlite_settings_repository.dart';
import 'package:nivelador_app/ui/pages/nivelator_page_results.dart';
import 'package:nivelador_app/ui/pages/nivelar_equipos_page.dart';
import 'package:nivelador_app/ui/pages/production_app.dart';
import 'bloc/Nivelator/bloc/nivelator_bloc.dart';
import 'bloc/bloc/jugador_bloc.dart';
import 'data/list_equipo_repository_interface.dart';
import 'main2.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

void main() {
  // IJugadorRepository repository = InMemoryJugadorRepository();
  // IListaEquipoRepository listaEquipoRepository = InMemoryListaEquipoRepository();

  IJugadorRepository repository = JugadorRepository();
  IListaEquipoRepository listaEquipoRepository = ListaEquipoRepository();
  ISettingsRepository settingsRepository = SQLiteSettingsRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => JugadoresBloc(jugadoresRepository: repository)
              ..add(LoadJugadoresEvent())),
        BlocProvider(
            create: (_) => NivelatorBloc(
                listaEquipoBalancecadoRepository: listaEquipoRepository,settingsRepository: settingsRepository)),
        BlocProvider(
            create: (_) => ListasGuardadasBloc(
                listaEquipoRepository: listaEquipoRepository)
              ..add(LoadListasGuardadasEvent())),
        BlocProvider(
            create: (_) => SettingsBloc(repository:settingsRepository)
              ..add(LoadSettingsEvent())),
      ],
      child: ProductionApp(),
    ),
  );
}
