part of 'nivelator_bloc.dart';

@immutable
sealed class NivelatorState extends Equatable{
    @override
  List<Object?> get props => [];
}

class NivelatorInitialState extends NivelatorState {

}

class NivelatorLoadingState extends NivelatorState {

}

class NivelatorLoadedState extends NivelatorState {
  List<Team> results;
  NivelateEvent nivelateEvent;
  NivelatorLoadedState({required this.results , required this.nivelateEvent});

  @override
  List<Object?> get props => [results,nivelateEvent];
}
