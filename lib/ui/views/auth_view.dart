import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:my_password_app/core/models/app_item.dart';
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
import 'package:provider/provider.dart';

class CheckAuth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider.of<LocalAuthModel?>(context)!.authenticate
        ? HomeView()
        : AuthView();
  }
}

class AuthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _screenData = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(UIHelper.edgeSmall),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'You Can Change this Setting Later',
                  style: CustomStyle.titleStyle,
                ),
                UIHelper.verticalSpaceSmall,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: SizedBox(
                        height: _screenData.width * 0.5,
                        child: ElevatedButtonWidget(
                          text: 'Enter With Local Auth',
                          onPressedParam: () async {
                            await Provider.of<LocalAuthModel?>(context,
                                    listen: false)!
                                .getAuthenticate();
                          },
                        ),
                      ),
                    ),
                    UIHelper.verticalSpaceSmall,
                    // Flexible(
                    //   child: SizedBox(
                    //     height: _screenData.width * 0.5,
                    //     child: ElevatedButtonWidget(
                    //       text: 'Enter With Custom PIN',
                    //       onPressedParam: () {},
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
