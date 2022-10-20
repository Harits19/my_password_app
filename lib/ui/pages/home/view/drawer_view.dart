import 'package:flutter/material.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_locale.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(KSize.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text("language".tr()),
            DropdownButton<Locale>(
              value: EasyLocalization.of(context)?.currentLocale,
              isExpanded: true,
              items: [
                ...KLocale.values.map(
                  (e) => DropdownMenuItem(
                    value: e.value,
                    onTap: () {
                      EasyLocalization.of(context)?.setLocale(e.value);
                    },
                    child: Text(
                      e.toString(),
                    ),
                  ),
                ),
              ],
              onChanged: (val) {},
            ),
            KSize.verti16,
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  "signOutGoogle".tr(),
                ),
                onPressed: () {
                  final authCubit = context.read<AuthCubit>();

                  ShowHelper.showLoading(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
