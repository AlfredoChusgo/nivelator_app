import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nivelador_app/bloc/Nivelator/bloc/nivelator_bloc.dart';
import 'package:nivelador_app/ui/pages/nivelator_page_results.dart';

import '../../main2.dart';
import '../../models/models.dart';

class NivelatorPageHome extends StatelessWidget {
  //ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NivelatorBloc, NivelatorState>(
          builder: (context, state) {
            return switch (state) {
              NivelatorInitialState() =>
                const Center(child: LinearProgressIndicator()),
              NivelatorLoadingState() => Column(
                  children: [
                    LinearProgressIndicator(
                      value: state.progress,
                    ),
                    Text(
                      '${(state.progress * 100).toStringAsFixed(0)}%',
                      style: TextStyle(fontSize: 16),
                    ),
                    Expanded(child:   Text(state.statusUpdate))
                    // Expanded(
                    //     child: ListView.builder(
                    //   //controller: scrollController,
                    //   itemCount: state.statusUpdate.length,
                    //   reverse: true,
                    //   itemBuilder: (context, index) {
                    //     return ListTile(
                    //       title: Text(state.statusUpdate[index]),
                    //     );
                    //   },
                    // ))
                  ],
                ),
              NivelatorLoadedState() => NivelatorPageResults(
                  teams: state.results,
                  nivelateEvent: state.nivelateEvent,
                )
            };
          },
        );
  }
}
