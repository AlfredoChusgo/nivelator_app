import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/bloc/jugador_bloc.dart';
import 'package:numberpicker/numberpicker.dart';

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
  IterationCategory iterationCategory = IterationCategory.moderate;

  final TextEditingController equiposController = TextEditingController(text: "4");
  late TextEditingController iteracionesController = TextEditingController(text: iterationCategory.toStringValue());

  final GlobalKey<_IntegerPickerState> _widgetKeyIntegerPicker = GlobalKey();
  final GlobalKey<_SelectJugadoresPageState> _widgetKeySelectJugadores = GlobalKey();

  // NiveladorEquipos(){
  //   iteracionesController = TextEditingController(text: iterationCategory.toStringValue());
  // }

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
              IntegerPicker(key: _widgetKeyIntegerPicker),
              SizedBox(height: 20),
              // Text('Cantidad de Iteraciones:'),
              TextField(
                controller: iteracionesController,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Cantidad de iteraciones', // This is the label text
                ),
                onTap: () async {
                  var result = await showModalBottomSheet<IterationCategory>(
                    context: context,
                    builder: (BuildContext context) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text("Iteraciones : ",style: Theme.of(context).textTheme.headlineSmall,),
                            ListTile(title: Text("Muy Baja"),onTap: () => Navigator.of(context).pop(IterationCategory.veryLow)),
                            ListTile(title: Text("Baja"),onTap: () => Navigator.of(context).pop(IterationCategory.low)),
                            ListTile(title: Text("Moderada"),onTap: () => Navigator.of(context).pop(IterationCategory.moderate)),
                            ListTile(title: Text("Alta"),onTap: () => Navigator.of(context).pop(IterationCategory.high)),
                            ListTile(title: Text("Muy Alta"),onTap: () => Navigator.of(context).pop(IterationCategory.veryHigh)),
                          ],
                        ),
                      );
                    },
                  );

                  if(result!=null){
                    iterationCategory = result;
                    iteracionesController.text = iterationCategory.toStringValue();
                  }
                },
                
              ),
            ],
          ),
        ),
        Expanded(
            child: SelectJugadoresPage(key: _widgetKeySelectJugadores)
            ),
            FloatingActionButton.extended (onPressed: () { 
              nivelarEquipos(context, _widgetKeyIntegerPicker.currentState?._currentValue ?? 4 , iterationCategory, _widgetKeySelectJugadores.currentState?.selectedItems ?? []);
             },
             icon: const Icon(Icons.access_alarm_sharp),
             label: const Text("Nivelar"),)            
      ],
    );
  }

    void nivelarEquipos(BuildContext context, int cantidadEquipos, IterationCategory  cantidadIteraciones, List<Jugador> jugadores) {

    context.read<NivelatorBloc>().add(NivelateEvent(
        cantidadEquipos: cantidadEquipos,
        cantidadIteraciones: cantidadIteraciones.toCantidadIteracionesValue(),
        jugadores: jugadores));

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NivelatorPageHome(),
      ),
    );
  }
}

class SelectJugadoresPage extends StatefulWidget {
      final Key? key;

  // Pass the key parameter to the superclass constructor
  const SelectJugadoresPage({this.key}) : super(key: key);
  @override
  _SelectJugadoresPageState createState() => _SelectJugadoresPageState();

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
                  title: Text("Seleccionar Todo | Cantidad : ${selectedItems.length}"),
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
                              // 'Ataque: ${jugador.ataque}, Defensa: ${jugador.defensa}'),
                              jugador.toString()),
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
      // bottomNavigationBar: BottomAppBar(
      //   child: Padding(
      //     padding: EdgeInsets.all(16.0),
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         Text(
      //           'Selected Count: ${selectedItems.length}',
      //           style: TextStyle(fontSize: 18),
      //         ),
      //         ElevatedButton(
      //           onPressed: () {
      //             widget.nivelarEquipos(context, selectedItems.toList());
      //           },
      //           child: Text('Nivelar'),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}


class IntegerPicker extends StatefulWidget {
    final Key? key;

  // Pass the key parameter to the superclass constructor
  const IntegerPicker({this.key}) : super(key: key);

  @override
  _IntegerPickerState createState() => _IntegerPickerState();
}

class _IntegerPickerState extends State<IntegerPicker> {
  int _currentValue = 4;
  int _minValue = 2 ;
  int _maxValue = 8 ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () => setState(() {
                if(_currentValue > _minValue){
                  final newValue = _currentValue - 1;
                _currentValue = newValue.clamp(0, 100);
                }                
              }),
            ),
        NumberPicker(
          value: _currentValue,
          minValue: _minValue,
          maxValue: _maxValue,
          axis: Axis.horizontal,
          onChanged: (value) => setState(() => _currentValue = value),
        ),
        IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => setState(() {
                if(_currentValue < _maxValue){
                  final newValue = _currentValue + 1;
                _currentValue = newValue.clamp(0, 100);
                }
                
              }),
            ),
      ],
    );
  }
}