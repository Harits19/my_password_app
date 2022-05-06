import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/auth.dart';
import 'package:my_password_app/ui/shared/custom_styles.dart';
import 'package:my_password_app/ui/shared/ui_helpers.dart';
import 'package:my_password_app/ui/views/home_view.dart';
import 'package:my_password_app/ui/widgets/custom_widget.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var isLocalAuth = false;
    var pin = '';
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: false
              ? LoadingWidget()
              : Padding(
                  padding: const EdgeInsets.all(UIHelper.edgeSmall),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: false
                        ? buildGettingStarted(pin, isLocalAuth)
                        : <Widget>[
                            TextFieldWidget(
                              hintText: 'Masukkan PIN',
                              obscureText: true,
                              onChanged: (newValue) {
                                pin = newValue;
                                print(pin);
                                // if (pin == authModel.data.value.pin) {
                                //   // SnackBarWidget.show(
                                //   //     title: 'Autentikasi',
                                //   //     message:
                                //   //         'Autentikasi dengan PIN berhasil');
                                //   // Get.off(() => HomeView());
                                //   Get.offAll(() => HomeView());
                                // }
                              },
                            ),
                            Text(
                              'Masukkan pin dan otomatis akan masuk',
                              style: CustomStyle.subtitleStyle,
                            ),
                            UIHelper.verticalSpaceLarge,
                            true
                                ? SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButtonWidget(
                                        text: 'Masuk dengan autentikasi lokal',
                                        onPressedParam: () async {
                                          // bool runLocalAuth =
                                          //     await authModel.runLocalAuth();
                                          // if (runLocalAuth) {
                                          //   // SnackBarWidget.show(
                                          //   //     title: 'Autentikasi',
                                          //   //     message:
                                          //   //         'Autentikasi lokal berhasil');
                                          //   // Get.off(() => HomeView());
                                          //   Get.offAll(() => HomeView());
                                          // }
                                        }),
                                  )
                                : Container(),
                          ],
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
            // bool checkAuth = await authModel.checkLocalAuth();
            // if (checkAuth) {
            //   setState(() => {isLocalAuth = !isLocalAuth});
            //   print(isLocalAuth);
            // } else {
            //   SnackBarWidget.show(
            //       title: 'Autentikasi',
            //       message: 'Autentikasi lokal tidak tersedia');
            // }
          },
        ),
      ),
      SizedBox(
        width: double.infinity,
        child: ElevatedButtonWidget(
          text: 'Save',
          onPressedParam: () {
            if (pin.isEmpty) {
              SnackBarWidget.show(
                  title: 'PIN',
                  message: 'PIN masih kosong, harap isi terlebih dahulu');
            } else {
              // authModel.addAuthModel(
              //   auth: Auth(pin: pin, isLocalAuth: isLocalAuth),
              // );
            }
          },
        ),
      ),
    ];
  }
}
