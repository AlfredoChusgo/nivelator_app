part of 'nivelator_bloc.dart';

@immutable
sealed class NivelatorState extends Equatable{
    @override
  List<Object?> get props => [];
}


class NivelatorLoadingState extends NivelatorState {

}

class NivelatorLoadedState extends NivelatorState {
  List<List<Jugador>> results;
  NivelatorLoadedState({required this.results});

  @override
  List<Object?> get props => [results];
}
