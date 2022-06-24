part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeDarkMode extends ThemeState {}

class ThemeLightMode extends ThemeState {}
