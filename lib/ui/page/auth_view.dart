import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:my_password_app/core/models/auth.dart';
import 'package:my_password_app/core/services/local_auth_service.dart';
import 'package:my_password_app/cubit/password_cubit.dart';
import 'package:my_password_app/ui/page/home_view.dart';
import 'package:my_password_app/ui/konstan/k_style.dart';
import 'package:my_password_app/ui/konstan/k_ui.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:my_password_app/ui/widgets/custom_widget.dart';
import 'package:my_password_app/utils/extensions.dart';
import 'package:my_password_app/utils/k_navigator.dart';

class CheckAuth extends StatefulWidget {
  @override
  State<CheckAuth> createState() => _CheckAuthState();
}

class _CheckAuthState extends State<CheckAuth> {
  var _useLocalAuth = false;
  var _pin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<PasswordCubit, PasswordState>(
          listener: (context, state) {
            if (state is PasswordError) {
              Show.snackbar(context, state.error);
            }
          },
          builder: (context, state) {
            if (state is PasswordError) {
              return SizedBox();
            }
            if (state is PasswordLoaded) {
              return Padding(
                padding: const EdgeInsets.all(KUi.edgeSmall),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.auth.pin.isNullEmpty)
                      ..._buildGettingStarted(state)
                    else
                      ..._buildAuth(state),
                  ],
                ),
              );
            }
            return LoadingWidget();
          },
        ),
      ),
    );
  }

  List<Widget> _buildAuth(PasswordLoaded state) {
    return [
      TextFieldWidget(
        hintText: 'Masukkan PIN',
        obscureText: true,
        onChanged: (newValue) {
          _pin = newValue;
          print(_pin);
          if (_pin == state.auth.pin) {
            Show.snackbar(context, "Autentikasi Berhasil");
            // KNavigator.pushAndReplace(context, HomeView());
          }
        },
      ),
      Text(
        'Masukkan pin dan otomatis akan masuk',
        style: KStyle.subtitleStyle,
      ),
      KUi.verticalSpaceLarge,
      if (state.isLocalAuthSupported)
        SizedBox(
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
    ];
  }

  List<Widget> _buildGettingStarted(PasswordLoaded state) {
    return [
      TextFieldWidget(
        hintText: 'Buat PIN',
        obscureText: true,
        onChanged: (newValue) {
          _pin = newValue;
          setState(() {});
        },
      ),
      KUi.verticalSpaceSmall,
      if (state.isLocalAuthSupported)
        CheckboxWidget(
          value: _useLocalAuth,
          text: 'Gunakan local auth?',
          onChanged: (newValue) async {
            _useLocalAuth = !_useLocalAuth;
            setState(() {});
          },
        ),
      SizedBox(
        width: double.infinity,
        child: ElevatedButtonWidget(
          text: 'Save',
          onPressedParam: () {
            if (_pin.isEmpty) {
              Show.snackbar(
                  context, 'PIN masih kosong, harap isi terlebih dahulu');
            } else {
              context.read<PasswordCubit>().postDataAuth(
                  auth: Auth(pin: _pin, useLocalAuth: _useLocalAuth));
            }
          },
        ),
      ),
    ];
  }
}
