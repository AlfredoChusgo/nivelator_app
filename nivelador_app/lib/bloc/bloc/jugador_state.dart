part of 'jugador_bloc.dart';

@immutable
sealed class JugadoresState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class JugadoresLoadingState extends JugadoresState {


  JugadoresLoadingState();

  @override
  List<Object?> get props => [];
}

final class JugadoresLoadedState extends JugadoresState {
  List<Jugador> jugadores;

  JugadoresLoadedState({required this.jugadores});

  @override
  List<Object?> get props => [jugadores];
}
