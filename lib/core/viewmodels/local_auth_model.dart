import 'package:flutter/cupertino.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';
import 'package:provider/provider.dart';

class LocalAuthModel extends ChangeNotifier {
  bool authenticate;

  LocalAuthModel({this.authenticate = false});

  void _setAuthenticated({required bool value}) {
    authenticate = value;
    notifyListeners();
    print(authenticate);
  }

  Future<void> getAuthenticate() async {
    var temp = await LocalAuthService.authenticate();
    _setAuthenticated(value: temp);
  }
}
