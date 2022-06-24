import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeDarkMode());

  void toggleTheme() {
    if (state is ThemeDarkMode) {
      emit(ThemeLightMode());
    } else {
      emit(ThemeDarkMode());
    }
  }
}
