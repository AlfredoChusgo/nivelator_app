import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/ui/pages/nivelator_page.dart';
import 'package:nivelador_app/ui/pages/configuration_page.dart';
import 'package:nivelador_app/ui/pages/home_page.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/bloc/jugador_bloc.dart';
import '../../models/models.dart';

//import 'models/models.dart';

class ProductionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CRUD de Jugadores',
        initialRoute: '/',
        routes: {
          '/': (_) {
            context.read<JugadoresBloc>().add(LoadJugadoresEvent());
            // return JugadoresListScreen();
            return HomePage();
          },
          // '/nivelator': (_) {
          //   //context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
          //   return const CircularProgressIndicator();
          // },
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),);
  }
}

