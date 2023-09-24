import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/ui/NivelatorUI.dart';
import 'package:nivelador_app/ui/configuration_ui.dart';
import 'bloc/Nivelator/bloc/nivelator_bloc.dart';
import 'bloc/bloc/jugador_bloc.dart';
import 'main2.dart';
import 'package:uuid/uuid.dart';

import 'models/models.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => JugadoresBloc()..add(LoadJugadoresEvent())),
        BlocProvider(create: (_) => NivelatorBloc())
      ],
      child: ProductionApp(),
    ),
  );
}

class ProductionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CRUD de Jugadores',
        initialRoute: '/',
        routes: {
          '/': (_) {
            context.read<JugadoresBloc>().add(LoadJugadoresEvent());
            return JugadoresListScreen();
          },
          // '/nivelator': (_) {
          //   //context.read<PacienteHomeBloc>().add(PacienteHomeRefreshEvent());
          //   return const CircularProgressIndicator();
          // },
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ));
  }
}

class JugadoresListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Aquí debes cargar la lista de jugadores desde la base de datos SQLite
    //final List<Jugador> jugadores = []; // Reemplaza con tus datos reales

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.navigate_next),
            onPressed: () {
              //Navigate to the NewScreen when the button is pressed
              //context.read<NivelatorBloc>().add(NivelateEvent());
              Navigator.of(context).push(
                MaterialPageRoute(
                  //builder: (context) => NivelatorPage(),
                  builder: (context) => ConfigurationUI(),
                ),
              );
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
                        'Ataque: ${jugador.ataque}, Defensa: ${jugador.defensa}'),
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

  @override
  Widget build(BuildContext context) {
    final jugadoresBloc = context.read<JugadoresBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Jugador'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Guardar el jugador en la base de datos y volver a la lista de jugadores
                  // Puedes implementar esta lógica

                  jugadoresBloc.add(CrearJugadorEvent(
                      jugador: Jugador(
                          id: Uuid().v4(),
                          nombre: nombreController.text,
                          ataque: int.parse(ataqueController.text),
                          defensa: int.parse(defensaController.text))));
                  jugadoresBloc.add(LoadJugadoresEvent());
                  Navigator.pop(context);
                },
                child: Text('Guardar'),
              ),
            ],
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

  EditarJugadorScreen({required this.jugador}){

    nombreController = TextEditingController(text: this.jugador.nombre);
    ataqueController = TextEditingController( text : this.jugador.ataque.toString());
    defensaController = TextEditingController(text : this.jugador.defensa.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Jugador'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
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
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Actualizar los datos del jugador en la base de datos y volver a la lista de jugadores
                  // Puedes implementar esta lógica
                  context.read<JugadoresBloc>().add(EditJugadorEvent(
                      jugador: Jugador(
                          id: jugador.id,
                          nombre: nombreController.text,
                          ataque: int.parse(ataqueController.text),
                          defensa: int.parse(defensaController.text))));
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
    );
  }
}
