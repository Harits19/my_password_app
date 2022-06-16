import 'package:get/get.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';

class LocalAuthModel extends GetxController {
  var authenticate = false.obs;

  @override
  void onInit() {
    // called immediately after the widget is allocated memory
    super.onInit();
  }

  void _setAuthenticated({required value}) {
    authenticate = value;
    print(authenticate);
  }

  Future<void> getAuthenticate() async {
    var temp = await LocalAuthService.authenticate();
    _setAuthenticated(value: temp);
  }
}
