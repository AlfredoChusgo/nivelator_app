import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'listas_guardadas_event.dart';
part 'listas_guardadas_state.dart';

class ListasGuardadasBloc extends Bloc<ListasGuardadasEvent, ListasGuardadasState> {
  ListasGuardadasBloc() : super(ListasGuardadasInitial()) {
    on<ListasGuardadasEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
