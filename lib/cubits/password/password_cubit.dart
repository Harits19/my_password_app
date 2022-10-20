import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_password_app/core/konstans/key.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/shared_prefs_service.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit()
      : super(
          PasswordState(
            listPassword: [],
            isAuthenticated: false,
            appPassword: null,
            passwordState: null,
          ),
        ) {
    restartTimer();
  }

  void getListPassword() {
    final listPassword = SharedPrefService.getListPassword();
    final appPassword = listPassword
        .where((element) => element.name == AppConfig.appPassword)
        .toList();
    if (appPassword.isEmpty) {
      emit(
        PasswordState(
          listPassword: listPassword,
          isAuthenticated: false,
          appPassword: null,
          passwordState: PasswordStateEnum.createAppPassword,
        ),
      );
      return;
    }

    emit(
      PasswordState(
        listPassword: listPassword,
        appPassword: appPassword.first,
        isAuthenticated: state.isAuthenticated,
        passwordState: PasswordStateEnum.loaded,
      ),
    );
  }

  Future<void> setAppPassword(String password) async {
    state.listPassword.add(
      PasswordModel(
        name: AppConfig.appPassword,
        password: password,
      ),
    );
    print('updated app password ${state.listPassword}');
    await SharedPrefService.setListPassword(state.listPassword);
    getListPassword();
  }

  void resetAuthentication() {
    emit(state.copyWith(
      isAuthenticated: false,
    ));
  }

  Timer? _sessionTimer;

  void restartTimer() {
    if (state.showAuthenticationDialog) return;
    print('restart timer');
    _sessionTimer?.cancel();
    _sessionTimer = Timer(AppConfig.sessionDuration, _onTimerEnd);
  }

  void _onTimerEnd() {
    print('_onTimerEnd');
    resetAuthentication();
  }
}
