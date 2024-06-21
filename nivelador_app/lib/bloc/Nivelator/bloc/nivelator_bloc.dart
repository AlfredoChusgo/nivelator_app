import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nivelador_app/business_logic/fixed_queue.dart';
import 'package:nivelador_app/business_logic/team_generator.dart';
import 'package:nivelador_app/data/settings_repository_interface.dart';
import 'package:nivelador_app/jugador_database.dart';
import 'package:uuid/uuid.dart';

import '../../../data/list_equipo_repository_interface.dart';
import '../../../main2.dart';
import '../../../models/models.dart';

part 'nivelator_event.dart';
part 'nivelator_state.dart';

class NivelatorBloc extends Bloc<NivelatorEvent, NivelatorState> {
  late IListaEquipoRepository listaEquipoBalancecadoRepository;
  late ISettingsRepository settingsRepository;
  late TeamGenerator teamGenerator;
  NivelatorBloc({required this.listaEquipoBalancecadoRepository, required this.settingsRepository})
      : super(NivelatorInitialState()) {

    teamGenerator = TeamGenerator();
    on<NivelateEvent>(_onNivelateEvent);
    on<SaveEquiposBalanceadosEvent>(_onSaveEquiposBalanceadosEvent);
    on<CancelNivelateEvent>(_onCancelNivelateEvent);
  }

  FutureOr<void> _onNivelateEvent(
      NivelateEvent event, Emitter<NivelatorState> emit) async {
    var jugadores = event.jugadores;

    // DivisorDeJugadores divisor = DivisorDeJugadores(
    //     jugadores: jugadores, cantidadGrupos: event.cantidadEquipos, jugadoresPorGrupo: event.jugadoresPorEquipo);
    // List<List<Jugador>> grupos = divisor.dividirJugadores();
    emit(NivelatorLoadingState(progress: 0,statusUpdate: ""));
    List<List<Team>> equipos = await teamGenerator.monteCarloBalance(
        jugadores,
        event.cantidadEquipos,
        event.cantidadIteraciones,
        (await settingsRepository.getSettings()).habilidadesPeso,onProgress: (p0,statusUpdate) => emit(NivelatorLoadingState(progress: p0,statusUpdate: statusUpdate)));
    
    emit(NivelatorLoadedState(results: equipos, nivelateEvent: event));
  }

  FutureOr<void> _onSaveEquiposBalanceadosEvent(
      SaveEquiposBalanceadosEvent event, Emitter<NivelatorState> emit) {
    listaEquipoBalancecadoRepository.saveListaEquipo(ListaEquipoBalanceado(
        id: const Uuid().v4(),
        nombre: event.nombreLista,
        equipos: event.teams,
        dateTime: DateTime.now()));
    //emit(NivelatorLoadingState());
  }

  FutureOr<void> _onCancelNivelateEvent(CancelNivelateEvent event, Emitter<NivelatorState> emit) {
      teamGenerator.cancelMonteCarloBalance();
  }
}
