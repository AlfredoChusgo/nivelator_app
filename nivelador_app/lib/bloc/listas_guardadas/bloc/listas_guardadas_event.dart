part of 'listas_guardadas_bloc.dart';


@immutable
sealed class ListasGuardadasEvent extends Equatable{}

class LoadListasGuardadasEvent extends ListasGuardadasEvent{
  @override
  List<Object?> get props => [];
}