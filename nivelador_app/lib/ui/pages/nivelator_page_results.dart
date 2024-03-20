import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/Nivelator/bloc/nivelator_bloc.dart';
import 'package:flutter/services.dart';

import '../../main2.dart';
import '../../models/models.dart';

class NivelatorPageResults extends StatelessWidget {
  late List<Team> teams;
  late NivelateEvent nivelateEvent;
  NivelatorPageResults({required this.teams, required this.nivelateEvent}) {}

  @override
  Widget build(BuildContext context) {
    return ListaEquipoBalanceadoWidget(teams: teams);
  }
}

class ListaEquipoBalanceadoWidget extends StatelessWidget {
  late List<Team> teams;
  ListaEquipoBalanceadoWidget({required this.teams});
  @override
  Widget build(BuildContext context) {
    var teamsGroupCards = teams.map((e) {
      int index = teams.indexOf(e);
      return TeamGroupCard(
        groupName: 'Equipo $index',
        team: e,
      );
    }).toList();

    var actions = Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                final result = await showDialog(
                    context: context,
                    builder: (BuildContext dialogBuildContext) {
                      return SaveEquiposBalanceadosDialog();
                    });
        
                if (result != null) {
                  context.read<NivelatorBloc>().add(
                      SaveEquiposBalanceadosEvent(
                          nombreLista: result['nombre'], teams: teams));
                  //Navigator.of(context).pop(context);
                  //Navigator.pop(context);
                } else {
                  print('Dialog closed without returning any value');
                }
              },
            ),
            // IconButton(
            //   icon: const Icon(Icons.refresh),
            //   onPressed: () {
            //     //context.read<NivelatorBloc>().add(nivelateEvent);
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.copy),
              onPressed: () {
                //context.read<NivelatorBloc>().add(nivelateEvent);
                Clipboard.setData(
                    ClipboardData(text: Team.toWhatsappMessage(teams)));
              },
            ),
          ],
        );
    return SingleChildScrollView(
      child: Column(
        children: [
                  Container(
            child: actions,
          ),
          Column(children: [
           
            ...teamsGroupCards,
             
          ]),
      
        ],
      ),
    );
  }
}

class TeamGroupCard extends StatelessWidget {
  final String groupName;
  final Team team;

  TeamGroupCard({required this.groupName, required this.team});

  @override
  Widget build(BuildContext context) {
    var tiles = team.players.map((jugador) => ListTile(
        title: Text(
            '${jugador.nombre} - Score : ${jugador.getScore(team.configuration).round()}'),
        subtitle: Text(jugador.habilidades.toString())));
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
          ...tiles,
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: NeverScrollableScrollPhysics(),
          //   itemCount: team.players.length,
          //   itemBuilder: (context, index) {
          //     var jugador = team.players[index];
          //     return ListTile(
          //         title: Text(
          //             '${jugador.nombre} - Score : ${jugador.getScore(team.configuration).round()}'),
          //         subtitle: Text(team.players[index].habilidades.toString()));
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Score : ${team.getTotalScore().round()}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class SaveEquiposBalanceadosDialog extends StatefulWidget {
  @override
  _SaveEquiposBalanceadosDialogState createState() =>
      _SaveEquiposBalanceadosDialogState();
}

class _SaveEquiposBalanceadosDialogState
    extends State<SaveEquiposBalanceadosDialog> {
  String nombre = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Nombre'),
            onChanged: (value) {
              setState(() {
                nombre = value;
              });
            },
          ),
          // SizedBox(height: 20),
          // TextField(
          //   enabled: false,
          //   decoration: InputDecoration(labelText: 'DateTime'),
          //   controller: TextEditingController(text: dateTime.toIso8601String()),
          //   ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle save operation here
            // For example, you can pass the entered values back to the caller
            Navigator.of(context).pop({'nombre': nombre});
          },
          child: Text('Guardar'),
        ),
      ],
    );
  }
}
