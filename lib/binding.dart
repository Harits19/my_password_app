import 'package:get/get.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/core/viewmodels/auth_model.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthModel(), fenix: true);
    Get.lazyPut(() => AppModel(), fenix: true);
  }
}
