part of 'listas_guardadas_bloc.dart';

@immutable
sealed class ListasGuardadasState extends Equatable{
    @override
  List<Object?> get props => [];
}

final class ListasGuardadasLoading extends ListasGuardadasState {}


class ListasGuardadasLoaded extends ListasGuardadasState {
  List<ListaEquipoBalanceado> results;

  ListasGuardadasLoaded({required this.results });

  @override
  List<Object?> get props => [results];
}
