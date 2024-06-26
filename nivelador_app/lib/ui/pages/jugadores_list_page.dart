import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/ui/pages/nivelator_page_results.dart';
import 'package:nivelador_app/ui/pages/nivelar_equipos_page.dart';
import 'package:nivelador_app/ui/pages/home_page.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/bloc/jugador_bloc.dart';
import '../../models/models.dart';


class JugadoresListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Aquí debes cargar la lista de jugadores desde la base de datos SQLite
    //final List<Jugador> jugadores = []; // Reemplaza con tus datos reales

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              //Navigate to the NewScreen when the button is pressed
              context.read<JugadoresBloc>().add(EmptyJugadoresEvent());
            },
          ),
          IconButton(
            icon: Icon(Icons.restore),
            onPressed: () {
              //Navigate to the NewScreen when the button is pressed
              context.read<JugadoresBloc>().add(RestoreDefaultValuesEvent());
            },
          ),
          BlocBuilder<JugadoresBloc, JugadoresState>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  if(state is JugadoresLoadedState){
                    Clipboard.setData(
                        ClipboardData(text: Jugador.getJsonFromJugadores(state.jugadores)));
                  }
                  
                },
              );
            }
          ),
          IconButton(
            icon: Icon(Icons.paste),
            onPressed: () async {
              //Navigate to the NewScreen when the button is pressed
              ClipboardData? clipboardData = await Clipboard.getData("text/plain");

              String data = clipboardData?.text ?? "";
              context.read<JugadoresBloc>().add(PasteJugadoresFromClipboard(data: data ));
            },
          ),
        ],
        title: Text('Lista de Jugadores'),
      ),
      body: BlocBuilder<JugadoresBloc, JugadoresState>(
        builder: (context, state) {
          return switch (state) {
            JugadoresLoadingState() =>
              const Center(child: CircularProgressIndicator()),
            JugadoresLoadedState() => ListView.builder(
                itemCount: state.jugadores.length,
                itemBuilder: (context, index) {
                  final jugador = state.jugadores[index];
                  return ListTile(
                    title: Text(jugador.nombre),
                    subtitle: Text(
                        jugador.habilidades.toString()),
                        
                    onTap: () {
                      // Navegar a la pantalla de detalles o edición de jugador
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditarJugadorScreen(jugador: jugador),
                        ),
                      );
                    },
                  );
                },
              ),
          };
          //return
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navegar a la pantalla de creación de jugador
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CrearJugadorScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CrearJugadorScreen extends StatelessWidget {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController ataqueController = TextEditingController();
  final TextEditingController defensaController = TextEditingController();
  final TextEditingController salvadaController = TextEditingController();
  final TextEditingController servidaController = TextEditingController();
  final TextEditingController teamplayController = TextEditingController();
  final TextEditingController saqueController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final jugadoresBloc = context.read<JugadoresBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Jugador'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            // Aquí puedes crear un formulario para ingresar datos del jugador
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: 'Nombre'),
                  controller: nombreController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Ataque'),
                  keyboardType: TextInputType.number,
                  controller: ataqueController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Defensa'),
                  keyboardType: TextInputType.number,
                  controller: defensaController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Salvada'),
                  keyboardType: TextInputType.number,
                  controller: salvadaController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'servida'),
                  keyboardType: TextInputType.number,
                  controller: servidaController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Teamplay'),
                  keyboardType: TextInputType.number,
                  controller: teamplayController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Saque'),
                  keyboardType: TextInputType.number,
                  controller: saqueController,
                ),
          
                
          
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Guardar el jugador en la base de datos y volver a la lista de jugadores
                    // Puedes implementar esta lógica
          
                    jugadoresBloc.add(CrearJugadorEvent(
                        jugador: Jugador(
                            id: Uuid().v4(),
                            nombre: nombreController.text,
                            habilidades: JugadorHabilidades(
                              ataque: num.parse(ataqueController.text),
                            defensa: num.parse(defensaController.text),
                            salvada: num.parse(salvadaController.text),
                            servida: num.parse(servidaController.text),
                            teamplay: num.parse(teamplayController.text),
                            saque: num.parse(saqueController.text),
                            )
                            )));
                    jugadoresBloc.add(LoadJugadoresEvent());
                    Navigator.pop(context);
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EditarJugadorScreen extends StatelessWidget {
  final Jugador jugador;
  late final TextEditingController nombreController;
  late final TextEditingController ataqueController;
  late final TextEditingController defensaController;
  late final TextEditingController salvadaController;
  late final TextEditingController servidaController;
  late final TextEditingController teamplayController;
  late final TextEditingController saqueController;

  EditarJugadorScreen({required this.jugador}){

    nombreController = TextEditingController(text: this.jugador.nombre);
    ataqueController = TextEditingController( text : this.jugador.habilidades.ataque.toString());
    defensaController = TextEditingController(text : jugador.habilidades.defensa.toString());
    salvadaController = TextEditingController(text : this.jugador.habilidades.salvada.toString());
    servidaController = TextEditingController(text : this.jugador.habilidades.servida.toString());
    teamplayController = TextEditingController(text : this.jugador.habilidades.teamplay.toString());
    saqueController = TextEditingController(text : this.jugador.habilidades.saque.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Jugador'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            // Aquí puedes crear un formulario para editar los datos del jugador
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  //initialValue: jugador.nombre,
                  decoration: InputDecoration(labelText: 'Nombre'),
                  controller: nombreController,
                ),
                TextFormField(
                  //initialValue: jugador.ataque.toString(),
                  decoration: InputDecoration(labelText: 'Ataque'),
                  keyboardType: TextInputType.number,
                  controller: ataqueController,
                ),
                TextFormField(
                  //initialValue: jugador.defensa.toString(),
                  decoration: InputDecoration(labelText: 'Defensa'),
                  keyboardType: TextInputType.number,
                  controller: defensaController,
                ),
                              TextFormField(
                  decoration: InputDecoration(labelText: 'Salvada'),
                  keyboardType: TextInputType.number,
                  controller: salvadaController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'servida'),
                  keyboardType: TextInputType.number,
                  controller: servidaController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Teamplay'),
                  keyboardType: TextInputType.number,
                  controller: teamplayController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Saque'),
                  keyboardType: TextInputType.number,
                  controller: saqueController,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Actualizar los datos del jugador en la base de datos y volver a la lista de jugadores
                    // Puedes implementar esta lógica
                    context.read<JugadoresBloc>().add(EditJugadorEvent(
                        jugador: Jugador(
                            id: jugador.id,
                            nombre: nombreController.text,
                            habilidades: JugadorHabilidades(
                              ataque: num.parse(ataqueController.text),
                              defensa: num.parse(defensaController.text),
                              salvada: num.parse(salvadaController.text),
                              servida: num.parse(servidaController.text),
                              teamplay: num.parse(teamplayController.text),
                              saque: num.parse(saqueController.text),
                            ))));
                    context.read<JugadoresBloc>().add(LoadJugadoresEvent());
                    Navigator.pop(context);
                  },
                  child: Text('Actualizar'),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Eliminar al jugador de la base de datos y volver a la lista de jugadores
                    // Puedes implementar esta lógica
                    context.read<JugadoresBloc>().add(EliminarJugadorEvent(id: jugador.id));
                    context.read<JugadoresBloc>().add(LoadJugadoresEvent());
                    Navigator.pop(context);
                  },
                  child: Text('Eliminar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
