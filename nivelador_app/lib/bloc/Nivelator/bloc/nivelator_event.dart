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

class SaveEquiposBalanceadosEvent extends NivelatorEvent{  
  String nombreLista;
  List<Team> teams;

  SaveEquiposBalanceadosEvent({required this.nombreLista,required this.teams});

  @override
  List<Object?> get props => [nombreLista,teams];
}
