import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../jugador_database.dart';
import '../../main2.dart';
import '../../models/models.dart';

part 'jugador_event.dart';
part 'jugador_state.dart';

class JugadoresBloc extends Bloc<JugadoresEvent, JugadoresState> {
  //final JugadorDatabase jugadorRepository;

  JugadoresBloc() : super(JugadoresLoadingState()) {
    on<LoadJugadoresEvent>(_onLoadJugadoresEvent);
    on<CrearJugadorEvent>(_onCrearJugadorEvent);
    on<EditJugadorEvent>(_onEditJugadorEvent);
    on<EliminarJugadorEvent>(_onEliminarJugadorEvent);
  }

  FutureOr<void> _onLoadJugadoresEvent(LoadJugadoresEvent event, Emitter<JugadoresState> emit) async {
    emit(JugadoresLoadingState());
    var jugadores = await  JugadorDatabase.getJugadores();
    emit(JugadoresLoadedState(jugadores: jugadores));
  }

  FutureOr<void> _onEliminarJugadorEvent(EliminarJugadorEvent event, Emitter<JugadoresState> emit) async {
    await JugadorDatabase.deleteJugador(event.id);
  }

  FutureOr<void> _onEditJugadorEvent(EditJugadorEvent event, Emitter<JugadoresState> emit) async {
    await JugadorDatabase.updateJugador(event.jugador);
  }

  FutureOr<void> _onCrearJugadorEvent(CrearJugadorEvent event, Emitter<JugadoresState> emit) async {
    await JugadorDatabase.insertJugador(event.jugador);
  }
}
