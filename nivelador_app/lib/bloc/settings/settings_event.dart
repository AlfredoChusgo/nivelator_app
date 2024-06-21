part of 'settings_bloc.dart';

@immutable
sealed class SettingsEvent extends Equatable {}

class LoadSettingsEvent extends SettingsEvent {   
  LoadSettingsEvent();

  @override
  List<Object?> get props => [];
}

class SaveSettingsEvent extends SettingsEvent {   
  Settings settings;
  SaveSettingsEvent({required this.settings});

  @override
  List<Object?> get props => [settings];
}