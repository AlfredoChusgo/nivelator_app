import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/Nivelator/bloc/nivelator_bloc.dart';

import '../../main2.dart';
import '../../models/models.dart';

class NivelatorPageResults extends StatelessWidget {
  late List<Team> teams;
  late NivelateEvent nivelateEvent;
  NivelatorPageResults({required this.teams, required this.nivelateEvent});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Equipos Balanceados'),
          actions: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                    context.read<NivelatorBloc>().add(nivelateEvent);    
              },
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: teams.length,
          itemBuilder: (context, index) {
            return GroupCard(
              groupName: 'Equipo ${index + 1}',
              team: teams[index],
            );
          },
        ),
      ),
    );
  }
}

class GroupCard extends StatelessWidget {
  final String groupName;
  final Team team;

  GroupCard({required this.groupName, required this.team});

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
            physics: ClampingScrollPhysics(),
            itemCount: team.players.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('ID: ${team.players[index].id}'),
                subtitle: Text('Nombre: ${team.players[index].nombre}'),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Ataque: ${team.players[index].ataque}'),
                    Text('Defensa: ${team.players[index].defensa}'),
                  ],
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Score : ${team.getTotalScore()}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
