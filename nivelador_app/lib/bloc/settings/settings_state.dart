part of 'settings_bloc.dart';

@immutable
sealed class SettingsState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SettingsLoadingState extends SettingsState {
  SettingsLoadingState();

  @override
  List<Object?> get props => [];
}


final class SettingsLoadedState extends SettingsState {
  Settings settings;
  SettingsLoadedState({required this.settings});

  @override
  List<Object?> get props => [settings];
}


// final class SettingsLoaded extends SettingsState {
//   Settings settings;
//   SettingsLoaded({required this.settings});

//   @override
//   List<Object?> get props => [settings];
// }
