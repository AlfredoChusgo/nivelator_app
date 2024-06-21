import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/settings/settings_bloc.dart';
import 'package:nivelador_app/ui/pages/nivelator_page_results.dart';
import 'package:nivelador_app/ui/pages/nivelar_equipos_page.dart';
import 'package:nivelador_app/ui/pages/home_page.dart';
import 'package:uuid/uuid.dart';

import '../../bloc/bloc/jugador_bloc.dart';
import '../../models/models.dart';

class EditarSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Opciones'),
        ),
        body: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            return switch (state){
              SettingsLoadingState() => const Center(child: CircularProgressIndicator()),
              SettingsLoadedState()=> EditarSettingsScreen(settings: state.settings)
            };
          },
        ),
      ),
    );
  }
}

class EditarSettingsScreen extends StatelessWidget {
  final Settings settings;
  late final TextEditingController ataqueController;
  late final TextEditingController defensaController;
  late final TextEditingController salvadaController;
  late final TextEditingController servidaController;
  late final TextEditingController teamplayController;
  late final TextEditingController saqueController;

  EditarSettingsScreen({required this.settings}) {
    ataqueController = TextEditingController(
        text: this.settings.habilidadesPeso.ataque.toString());
    defensaController = TextEditingController(
        text: settings.habilidadesPeso.defensa.toString());
    salvadaController = TextEditingController(
        text: this.settings.habilidadesPeso.salvada.toString());
    servidaController = TextEditingController(
        text: this.settings.habilidadesPeso.servida.toString());
    teamplayController = TextEditingController(
        text: this.settings.habilidadesPeso.teamplay.toString());
    saqueController = TextEditingController(
        text: this.settings.habilidadesPeso.saque.toString());        
  }

  String? _validateNumber(String value) {
    try {
      // Parse the input value as a double
      double number = double.parse(value);

      // Define your range
      double minValue = 0.0;
      double maxValue = 100.0;

      // Validate if the number is within the range
      if (number < minValue || number > maxValue) {
        return 'Number must be between $minValue and $maxValue';
      }
    } catch (e) {
      return 'Invalid number format';
    }

    return null; // Return null if validation passes
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            // Aquí puedes crear un formulario para editar los datos del jugador
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  //initialValue: jugador.ataque.toString(),
                  decoration: InputDecoration(labelText: 'Ataque peso'),

                  keyboardType: TextInputType.number,
                  controller: ataqueController,
                  validator: (value) => _validateNumber(value ?? ''),
                ),
                TextFormField(
                  //initialValue: jugador.defensa.toString(),
                  decoration: InputDecoration(labelText: 'Defensa peso'),
                  keyboardType: TextInputType.number,
                  controller: defensaController,
                  validator: (value) => _validateNumber(value ?? ''),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Salvada peso'),
                  keyboardType: TextInputType.number,
                  controller: salvadaController,
                  validator: (value) => _validateNumber(value ?? ''),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'servida peso'),
                  keyboardType: TextInputType.number,
                  controller: servidaController,
                  validator: (value) => _validateNumber(value ?? ''),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Teamplay peso'),
                  keyboardType: TextInputType.number,
                  controller: teamplayController,
                  validator: (value) => _validateNumber(value ?? ''),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Saque peso'),
                  keyboardType: TextInputType.number,
                  controller: saqueController,
                  validator: (value) => _validateNumber(value ?? ''),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    bool isValid = false;
                    Map<String,num> inputValues = {
                      "pesoAtaque":num.parse(ataqueController.text),
                      "defensaAtaque":num.parse(defensaController.text),
                      "salvadaAtaque":num.parse(salvadaController.text),
                      "servidaAtaque":num.parse(servidaController.text),
                      "teamplayAtaque":num.parse(teamplayController.text),
                      "saqueAtaque":num.parse(saqueController.text),
                    };

                    List<String> errorList = [];
                    inputValues.entries.forEach((element) {                       
                      if(element.value <= 0  || element.value > 1){
                        errorList.add("${element.key} tiene que ser mayor a 0 y menor a 1 ");
                      }
                    });

                    isValid = errorList.isEmpty;
                    if(isValid){
                      context.read<SettingsBloc>().add(SaveSettingsEvent(
                            settings: Settings(
                                habilidadesPeso: HabilidadesPeso(
                          ataque: num.parse(ataqueController.text),
                          defensa: num.parse(defensaController.text),
                          salvada: num.parse(salvadaController.text),
                          servida: num.parse(servidaController.text),
                          teamplay: num.parse(teamplayController.text),
                          saque: num.parse(saqueController.text),
                        ))));
                    context.read<JugadoresBloc>().add(LoadJugadoresEvent());

                    
                      var snackBar = const SnackBar(
                      content: Text("Opciones guardadas"),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      
                    }else{
                      var errorText = errorList.toString();
                      var snackBar = SnackBar(
                      content: Text(errorText),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('Actualizar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
