import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nivelador_app/models/models.dart';

import '../../../data/list_equipo_repository_interface.dart';

part 'listas_guardadas_event.dart';
part 'listas_guardadas_state.dart';

class ListasGuardadasBloc extends Bloc<ListasGuardadasEvent, ListasGuardadasState> {
  late IListaEquipoRepository listaEquipoRepository;
  ListasGuardadasBloc({required this.listaEquipoRepository}) : super(ListasGuardadasLoading()) {
    on<LoadListasGuardadasEvent>(_onLoadListasGuardadasEvent);
  }

  FutureOr<void> _onLoadListasGuardadasEvent(LoadListasGuardadasEvent event, Emitter<ListasGuardadasState> emit) async {

    var results = await  listaEquipoRepository.getAllListaEquipo();
    results.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    emit(ListasGuardadasLoaded(results: results));
  }
}
