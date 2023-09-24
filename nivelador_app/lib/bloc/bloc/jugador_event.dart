part of 'jugador_bloc.dart';

@immutable
sealed class JugadoresEvent extends Equatable {}


class LoadJugadoresEvent extends JugadoresEvent {   
  LoadJugadoresEvent();

  @override
  List<Object?> get props => [];
}

class CrearJugadorEvent extends JugadoresEvent {   
  Jugador jugador;
  CrearJugadorEvent({required this.jugador});

  @override
  List<Object?> get props => [jugador];
}

class EditJugadorEvent extends JugadoresEvent {   
  Jugador jugador;
  EditJugadorEvent({required this.jugador});

  @override
  List<Object?> get props => [jugador];
}

class EliminarJugadorEvent extends JugadoresEvent {   
  String id;
  EliminarJugadorEvent({required this.id});

  @override
  List<Object?> get props => [id];
}