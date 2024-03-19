import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/Nivelator/bloc/nivelator_bloc.dart';
import 'package:nivelador_app/ui/pages/nivelator_page_results.dart';

import '../../main2.dart';
import '../../models/models.dart';

class NivelatorPageHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: BlocBuilder<NivelatorBloc, NivelatorState>(
          builder: (context, state) {

            return switch (state){
              NivelatorInitialState() => const Center(child: LinearProgressIndicator()),
              NivelatorLoadingState() => Center(child: LinearProgressIndicator(
                value: state.progress,
              )),
              NivelatorLoadedState() => NivelatorPageResults(teams: state.results,nivelateEvent: state.nivelateEvent,)
            };
          },
        ),
      ),
    );
  }

}


