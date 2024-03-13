import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nivelador_app/business_logic/team_generator.dart';
import 'package:nivelador_app/jugador_database.dart';

import '../../../main2.dart';
import '../../../models/models.dart';

part 'nivelator_event.dart';
part 'nivelator_state.dart';

class NivelatorBloc extends Bloc<NivelatorEvent, NivelatorState> {
  NivelatorBloc() : super(NivelatorLoadingState()) {
    on<NivelateEvent>(_onNivelateEvent);
  }

  FutureOr<void> _onNivelateEvent(
      NivelateEvent event, Emitter<NivelatorState> emit) async {
    var jugadores =event.jugadores;

    // DivisorDeJugadores divisor = DivisorDeJugadores(
    //     jugadores: jugadores, cantidadGrupos: event.cantidadEquipos, jugadoresPorGrupo: event.jugadoresPorEquipo);
    // List<List<Jugador>> grupos = divisor.dividirJugadores();
    int numTeams = 4;
    List<Team> equipos = TeamGenerator().monteCarloBalance(jugadores, numTeams, defensaWeight: 0.5, ataqueWeight: 1,salvadaWeight: 0.25,saqueWeight: 0.1,servidaWeight: 0.7,teamplayWeight: 0.3);
    
    emit(NivelatorLoadedState(results: equipos));
  }
}
