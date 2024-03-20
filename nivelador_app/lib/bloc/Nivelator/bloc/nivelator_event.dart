part of 'nivelator_bloc.dart';

@immutable
sealed class NivelatorEvent extends Equatable{}

class NivelateEvent extends NivelatorEvent{
  int cantidadEquipos;
  int cantidadIteraciones;
  List<Jugador> jugadores;

  NivelateEvent({required this.cantidadEquipos,required this.cantidadIteraciones,required this.jugadores});

  @override
  List<Object?> get props => [cantidadEquipos,cantidadIteraciones,jugadores];
}

class SaveEquiposBalanceadosEvent extends NivelatorEvent{  
  String nombreLista;
  List<Team> teams;

  SaveEquiposBalanceadosEvent({required this.nombreLista,required this.teams});

  @override
  List<Object?> get props => [nombreLista,teams];
}

class CancelNivelateEvent extends NivelatorEvent{      

  @override
  List<Object?> get props => [];
}
