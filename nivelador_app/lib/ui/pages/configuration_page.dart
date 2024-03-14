import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/bloc/jugador_bloc.dart';

import '../../bloc/Nivelator/bloc/nivelator_bloc.dart';
import '../../models/models.dart';
import 'nivelator_page_home.dart';
import 'nivelator_page_results.dart';

class ConfigurationPage extends StatelessWidget {
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
  final TextEditingController iteracionesController = TextEditingController(text: "1000000");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Cantidad de Equipos:'),
              TextField(
                controller: equiposController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              Text('Cantidad de Iteraciones:'),
              TextField(
                controller: iteracionesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'un numero entre 1000 - 1000000', // This is the label text
                ),
                
              ),
            ],
          ),
        ),
        Expanded(
            child: SelectJugadoresPage(
                equiposController: equiposController,
                iteracionesController: iteracionesController))
      ],
    );
  }
}

class SelectJugadoresPage extends StatefulWidget {
  final TextEditingController equiposController;
  final TextEditingController iteracionesController;
  SelectJugadoresPage(
      {required TextEditingController this.equiposController,
      required TextEditingController this.iteracionesController});
  @override
  _SelectJugadoresPageState createState() => _SelectJugadoresPageState();

  void nivelarEquipos(BuildContext context, List<Jugador> jugadores) {
    final int cantidadEquipos = int.tryParse(equiposController.text) ?? 0;
    final int cantidadIteraciones = int.tryParse(iteracionesController.text) ?? 0;

    context.read<NivelatorBloc>().add(NivelateEvent(
        cantidadEquipos: cantidadEquipos,
        cantidadIteraciones: cantidadIteraciones,
        jugadores: jugadores));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NivelatorPageHome(),
      ),
    );
  }
}

class _SelectJugadoresPageState extends State<SelectJugadoresPage> {
  List<Jugador> selectedItems = [];

  void toggleSelection(Jugador item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  void toggleAll(List<Jugador> listaJugadores) {
    setState(() {
      if (selectedItems.length == listaJugadores.length) {
        selectedItems = [];
      } else {
        selectedItems = [...listaJugadores];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          BlocBuilder<JugadoresBloc, JugadoresState>(builder: (context, state) {
        return switch (state) {
          JugadoresLoadingState() =>
            const Center(child: CircularProgressIndicator()),
          JugadoresLoadedState() => Column(
              children: [
                ListTile(
                  tileColor: Theme.of(context).colorScheme.outlineVariant,
                  title: Text("Seleccionar Todo"),
                  leading: Checkbox(
                    value: false,
                    onChanged: (_) {
                      toggleAll(state.jugadores);
                    },
                  ),
                  onTap: () {
                    toggleAll(state.jugadores);
                  },
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.jugadores.length,
                      itemBuilder: (context, index) {
                        //final jugador = state.jugadores[index];
                        //final item = items[index];

                        final jugador = state.jugadores[index];
                        final isSelected = selectedItems.contains(jugador);

                        return ListTile(
                          title: Text(jugador.nombre),
                          subtitle: Text(
                              'Ataque: ${jugador.ataque}, Defensa: ${jugador.defensa}'),
                          leading: Checkbox(
                            value: isSelected,
                            onChanged: (_) {
                              toggleSelection(jugador);
                            },
                          ),
                          onTap: () {
                            toggleSelection(jugador);
                          },
                        );
                      }),
                )
              ],
            )
        };
      }),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selected Count: ${selectedItems.length}',
                style: TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.nivelarEquipos(context, selectedItems.toList());
                },
                child: Text('Nivelar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
