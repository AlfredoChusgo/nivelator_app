import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/ui/pages/production_app.dart';

import 'configuration_page.dart';
import 'jugadores_list_page.dart';
import 'list_equipo_balanceado_home.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Administracion',
          ),
        ),
        bottomNavigationBar: const NavigationExample(),
      ),
    );
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({super.key});

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Jugadores',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Equipos Balanceados',
          ),
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Nivelar',
          )
        ],
      ),
      body: <Widget>[
        Container(
          //color: Colors.red,
          alignment: Alignment.center,
          child: JugadoresListScreen(),
        ),
        Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: ListaEquipoBalanceadoHome()),
        Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: ConfigurationPage()),
        //child: const EstadiaPacienteHomePage()),
      ][currentPageIndex],
    );
  }

  // Widget getPacienteHomePage() {
  //   context
  //       .read<PacienteHomeBloc>()
  //       .add(PacienteHomeRefreshEvent());
  //   return const PacienteHomePage();
  // }

  // Widget getEstadiaPacienteHomePage() {
  //   context
  //       .read<EstadiaPacienteHomeBloc>()
  //       .add(EstadiaPacienteHomeRefreshEvent());
  //   return const EstadiaPacienteHomePage();
  // }
}
