import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_password_app/core/models/app.dart';
import 'package:my_password_app/core/models/auth.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/core/viewmodels/auth_model.dart';
import 'package:my_password_app/core/viewmodels/local_auth_model.dart';
import 'package:my_password_app/ui/shared/custom_styles.dart';
import 'package:my_password_app/ui/shared/ui_helpers.dart';
import 'package:my_password_app/ui/views/home_view.dart';
import 'package:my_password_app/ui/widgets/custom_widget.dart';

class CheckAuth extends StatelessWidget {
  final AuthModel authModel = Get.put(AuthModel());

  @override
  Widget build(BuildContext context) {
    var isLocalAuth = false;
    var pin = '';
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Center(
            child: authModel.loading.isTrue
                ? LoadingWidget()
                : Padding(
                    padding: const EdgeInsets.all(UIHelper.edgeSmall),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: authModel.data.value.pin!.isEmpty
                          ? buildGettingStarted(pin, isLocalAuth)
                          : <Widget>[
                              TextFieldWidget(
                                hintText: 'Masukkan PIN',
                                obscureText: true,
                                onChanged: (newValue) {
                                  pin = newValue;
                                  print(pin);
                                  if (pin == authModel.data.value.pin) {
                                    SnackBarWidget.show(
                                        title: 'Autentikasi',
                                        message:
                                            'Autentikasi dengan PIN berhasil');
                                    Get.off(() => HomeView());
                                  }
                                },
                              ),
                              Text(
                                'Masukkan pin dan otomatis akan masuk',
                                style: CustomStyle.subtitleStyle,
                              ),
                              UIHelper.verticalSpaceLarge,
                              authModel.data.value.isLocalAuth == true
                                  ? SizedBox(
                                      width: Get.size.width,
                                      child: ElevatedButtonWidget(
                                          text:
                                              'Masuk dengan autentikasi lokal',
                                          onPressedParam: () async {
                                            bool runLocalAuth =
                                                await authModel.runLocalAuth();
                                            if (runLocalAuth) {
                                              SnackBarWidget.show(
                                                  title: 'Autentikasi',
                                                  message:
                                                      'Autentikasi lokal berhasil');
                                              Get.off(() => HomeView());
                                            }
                                          }),
                                    )
                                  : Container(),
                            ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildGettingStarted(String pin, bool isLocalAuth) {
    return [
      TextFieldWidget(
        hintText: 'Buat PIN',
        obscureText: true,
        onChanged: (newValue) {
          pin = newValue;
          print(pin);
        },
      ),
      UIHelper.verticalSpaceSmall,
      StatefulBuilder(
        builder: (context, setState) => CheckboxWidget(
          value: isLocalAuth,
          text: 'Gunakan local auth?',
          onChanged: (newValue) async {
            bool checkAuth = await authModel.checkLocalAuth();
            if (checkAuth) {
              setState(() => {isLocalAuth = !isLocalAuth});
              print(isLocalAuth);
            } else {
              SnackBarWidget.show(
                  title: 'Autentikasi',
                  message: 'Autentikasi lokal tidak tersedia');
            }
          },
        ),
      ),
      SizedBox(
        width: Get.size.width,
        child: ElevatedButtonWidget(
          text: 'Save',
          onPressedParam: () {
            if (pin.isEmpty) {
              SnackBarWidget.show(
                  title: 'PIN',
                  message: 'PIN masih kosong, harap isi terlebih dahulu');
            } else {
              authModel.addAuthModel(
                auth: Auth(pin: pin, isLocalAuth: isLocalAuth),
              );
            }
          },
        ),
      ),
    ];
  }
}
