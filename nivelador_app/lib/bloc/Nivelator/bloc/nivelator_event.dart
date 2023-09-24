part of 'nivelator_bloc.dart';

@immutable
sealed class NivelatorEvent extends Equatable{}

class NivelateEvent extends NivelatorEvent{
  int cantidadEquipos;
  int jugadoresPorEquipo;

  NivelateEvent({required this.cantidadEquipos,required this.jugadoresPorEquipo});

  @override
  List<Object?> get props => [cantidadEquipos,jugadoresPorEquipo];
}
