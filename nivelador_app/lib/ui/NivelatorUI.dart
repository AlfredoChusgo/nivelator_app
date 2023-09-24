import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/Nivelator/bloc/nivelator_bloc.dart';

import '../main2.dart';
import '../models/models.dart';

class NivelatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jugadores Grupos'),
        ),
        body: BlocBuilder<NivelatorBloc, NivelatorState>(
          builder: (context, state) {

            return switch (state){
              NivelatorLoadingState() => const Center(child: CircularProgressIndicator()),
              NivelatorLoadedState() => ListView.builder(
              itemCount: state.results.length,
              itemBuilder: (context, index) {
                return GroupCard(
                  groupName: 'Grupo ${index + 1}',
                  jugadores: state.results[index],
                );
              },
            )


            };
          },
        ),
      ),
    );
  }

}

class GroupCard extends StatelessWidget {
  final String groupName;
  final List<Jugador> jugadores;

  GroupCard({required this.groupName, required this.jugadores});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              groupName,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: jugadores.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('ID: ${jugadores[index].id}'),
                subtitle: Text('Nombre: ${jugadores[index].nombre}'),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Ataque: ${jugadores[index].ataque}'),
                    Text('Defensa: ${jugadores[index].defensa}'),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
