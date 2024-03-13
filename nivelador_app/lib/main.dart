import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/data/in_memory_jugador_repository.dart';
import 'package:nivelador_app/data/jugador_repository_interface.dart';
import 'package:nivelador_app/ui/pages/nivelator_page.dart';
import 'package:nivelador_app/ui/pages/configuration_page.dart';
import 'package:nivelador_app/ui/pages/production_app.dart';
import 'bloc/Nivelator/bloc/nivelator_bloc.dart';
import 'bloc/bloc/jugador_bloc.dart';
import 'main2.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

void main() {
  IJugadorRepository repository = InMemoryJugadorRepository();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => JugadoresBloc(jugadoresRepository: repository)..add(LoadJugadoresEvent())),
        BlocProvider(create: (_) => NivelatorBloc())
      ],
      child: ProductionApp(),
    ),
  );
}
