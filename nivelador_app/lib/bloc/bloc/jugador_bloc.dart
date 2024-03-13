import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nivelador_app/data/jugador_repository_interface.dart';

import '../../jugador_database.dart';
import '../../main2.dart';
import '../../models/models.dart';

part 'jugador_event.dart';
part 'jugador_state.dart';

class JugadoresBloc extends Bloc<JugadoresEvent, JugadoresState> {
  //final JugadorDatabase jugadorRepository;
  final IJugadorRepository jugadoresRepository;
  JugadoresBloc({required IJugadorRepository  this.jugadoresRepository}) : super(JugadoresLoadingState()) {
    on<LoadJugadoresEvent>(_onLoadJugadoresEvent);
    on<CrearJugadorEvent>(_onCrearJugadorEvent);
    on<EditJugadorEvent>(_onEditJugadorEvent);
    on<EliminarJugadorEvent>(_onEliminarJugadorEvent);
  }

  FutureOr<void> _onLoadJugadoresEvent(LoadJugadoresEvent event, Emitter<JugadoresState> emit) async {
    emit(JugadoresLoadingState());
    //var jugadores = await  JugadorDatabase.getJugadores();
    var jugadores = await  jugadoresRepository.getJugadores();
    emit(JugadoresLoadedState(jugadores: jugadores));
  }

  FutureOr<void> _onEliminarJugadorEvent(EliminarJugadorEvent event, Emitter<JugadoresState> emit) async {
    await jugadoresRepository.deleteJugador(event.id);
  }

  FutureOr<void> _onEditJugadorEvent(EditJugadorEvent event, Emitter<JugadoresState> emit) async {
    await jugadoresRepository.updateJugador(event.jugador.id,event.jugador);
  }

  FutureOr<void> _onCrearJugadorEvent(CrearJugadorEvent event, Emitter<JugadoresState> emit) async {
    await jugadoresRepository.createJugador(event.jugador);
  }
}
