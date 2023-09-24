import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Nivelator/bloc/nivelator_bloc.dart';
import 'NivelatorUI.dart';

class ConfigurationUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nivelador de Equipos'),
        ),
        body: NiveladorEquipos(),
      ),
    );
  }
}

class NiveladorEquipos extends StatelessWidget {
  final TextEditingController equiposController = TextEditingController();
  final TextEditingController jugadoresController = TextEditingController();

  void nivelarEquipos(BuildContext context) {
    final int cantidadEquipos = int.tryParse(equiposController.text) ?? 0;
    final int cantidadJugadores = int.tryParse(jugadoresController.text) ?? 0;
    context.read<NivelatorBloc>().add(NivelateEvent(
        cantidadEquipos: cantidadEquipos,
        jugadoresPorEquipo: cantidadJugadores));
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NivelatorPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Cantidad de Equipos:'),
          TextField(
            controller: equiposController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          Text('Cantidad de Jugadores:'),
          TextField(
            controller: jugadoresController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              nivelarEquipos(context);
            },
            child: Text('Nivelar'),
          ),
        ],
      ),
    );
  }
}
