import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:my_password_app/core/models/auth.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';
import 'package:my_password_app/core/services/secure_storage_service.dart';
import 'package:equatable/equatable.dart';

part 'password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitial());

  final _secureStorage = GetIt.I.get<SecureStorageV2>();
  final _localAuth = GetIt.I.get<LocalAuthServiceV2>();

  Future<void> getDataAuth() async {
    emit(PasswordLoading());
    try {
      final temp = await _secureStorage.readStorageAuthModel();
      final isLocalAuthSupported = await _localAuth.isDeviceSupported();
      if (temp != null) {
        var parsed = json.decode(temp);
        final data = Auth.fromJson(parsed);
        emit(PasswordLoaded(data, isLocalAuthSupported: isLocalAuthSupported));
      } else {
        final data = Auth(pin: '', useLocalAuth: false);
        emit(PasswordLoaded(data, isLocalAuthSupported: isLocalAuthSupported));
      }
    } catch (e) {
      print(e);
      emit(PasswordError(e));
    }
  }

  Future<void> postDataAuth({required Auth auth}) async {
    try {
      emit(PasswordLoading());
      await _secureStorage.writeStorageAuthModel(data: auth);
      getDataAuth();
    } catch (e) {
      emit(PasswordError(e));
    }
  }
}
