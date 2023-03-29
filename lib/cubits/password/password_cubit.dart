import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/konstans/key.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/core/services/shared_prefs_service.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordOldState> {
  PasswordCubit()
      : super(
          PasswordOldState(
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
        PasswordOldState(
          listPassword: listPassword,
          isAuthenticated: false,
          appPassword: null,
          passwordState: PasswordStateEnum.createAppPassword,
        ),
      );
      return;
    }

    emit(
      PasswordOldState(
        listPassword: listPassword,
        appPassword: appPassword.first,
        isAuthenticated: state.isAuthenticated,
        passwordState: PasswordStateEnum.loaded,
      ),
    );
  }

  Future<void> setAppPassword(String password) async {
    final listPassword = state.listPassword;
    listPassword.removeWhere(
      (element) => element.name == AppConfig.appPassword,
    );

    addPassword(
      passwordModel: PasswordModel(
        name: AppConfig.appPassword,
        password: password,
      ),
    );
    print('updated app password ${state.listPassword}');
    await updateListPassword();
  }

  void authenticatingAppPassword(String password) {
    final appPassword = state.appPassword?.password;
    if (appPassword.isNullEmpty) {
      throw 'Empty app password';
    }
    if (appPassword != password) {
      throw 'Password don\'t match';
    }
  }

  Future<void> updateListPassword() async {
    await SharedPrefService.setListPassword(state.listPassword);
    getListPassword();
  }

  void deletePassword(PasswordModel password) async {
    state.listPassword.removeWhere((element) => element.name == password.name);
    await updateListPassword();
  }

  void updatePassword({
    required int index,
    required PasswordModel passwordModel,
  }) {
    state.listPassword[index] = passwordModel;
    updateListPassword();
  }

  Future<void> addPassword({required PasswordModel passwordModel}) async {
    state.listPassword.add(passwordModel);
    await updateListPassword();
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
