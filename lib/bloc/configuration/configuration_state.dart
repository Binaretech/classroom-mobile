part of 'configuration_bloc.dart';

class ConfigurationState extends Equatable {
  final Locale locale;
  final ThemeMode themeMode;

  const ConfigurationState(
      {this.locale = const Locale('es'), this.themeMode = ThemeMode.system});

  @override
  List<Object> get props => [locale.languageCode, themeMode];
}
