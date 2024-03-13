part of 'nivelator_bloc.dart';

@immutable
sealed class NivelatorEvent extends Equatable{}

class NivelateEvent extends NivelatorEvent{
  int cantidadEquipos;
  int jugadoresPorEquipo;
  List<Jugador> jugadores;

  NivelateEvent({required this.cantidadEquipos,required this.jugadoresPorEquipo,required this.jugadores});

  @override
  List<Object?> get props => [cantidadEquipos,jugadoresPorEquipo,jugadores];
}
