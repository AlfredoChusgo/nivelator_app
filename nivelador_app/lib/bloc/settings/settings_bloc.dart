import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:nivelador_app/data/jugador_repository_interface.dart';
import 'package:nivelador_app/data/settings_repository_interface.dart';
import 'package:nivelador_app/models/models.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final ISettingsRepository repository;
  
  SettingsBloc({required this.repository})
      : super(SettingsLoadingState()) {
    on<LoadSettingsEvent>((event, emit) async {
      emit(SettingsLoadingState());
      var models = await repository.getSettings();
      emit(SettingsLoadedState(settings: models));
    });

    on<SaveSettingsEvent>((event, emit) async {
      emit(SettingsLoadingState());
      await repository.updateSettings(event.settings);
      var models = await repository.getSettings();
      emit(SettingsLoadedState(settings: models));
    });
  }
}
