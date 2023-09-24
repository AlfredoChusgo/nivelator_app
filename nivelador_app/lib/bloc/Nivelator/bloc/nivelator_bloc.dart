import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
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
    var jugadores = await JugadorDatabase.getJugadores();

    DivisorDeJugadores divisor = DivisorDeJugadores(
        jugadores: jugadores, cantidadGrupos: event.cantidadEquipos, jugadoresPorGrupo: event.jugadoresPorEquipo);
    List<List<Jugador>> grupos = divisor.dividirJugadores();
    emit(NivelatorLoadedState(results: grupos));
  }
}
