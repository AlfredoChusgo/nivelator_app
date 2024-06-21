import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/listas_guardadas/bloc/listas_guardadas_bloc.dart';
import 'package:nivelador_app/ui/pages/nivelator_page_results.dart';
import 'package:nivelador_app/ui/pages/nivelar_equipos_page.dart';
import 'package:nivelador_app/ui/pages/home_page.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/bloc/jugador_bloc.dart';
import '../../models/models.dart';


class ListaEquipoBalanceadoHome extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [            
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                    context.read<ListasGuardadasBloc>().add(LoadListasGuardadasEvent());    
              },
            ),],
        title: Text('Lista de equipos balanceados'),
      ),
      body: BlocBuilder<ListasGuardadasBloc, ListasGuardadasState>(
          builder: (context, state) {

            return switch (state){
              ListasGuardadasLoading() => const Center(child: CircularProgressIndicator()),
              ListasGuardadasLoaded() => ListView.builder(
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                  final lista = state.results[index];
                  return ListTile(
                    title: Text(lista.nombre),
                    subtitle: Text("fecha : ${lista.dateTime.toIso8601String()}"),
                    onTap: () {
                      // Navegar a la pantalla de detalles o edición de jugador
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ListaEquipoBalanceadoWidget(teams: List<List<Team>>.of([lista.equipos])),
                        ),
                      );
                    },
                  );
                },
              ),
            };
          },
        ),
    );
  }
}

