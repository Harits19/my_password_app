import 'package:flutter/material.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(KSize.medium),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: Text(
                  "signOutGoogle".tr(),
                ),
                onPressed: () {
                  final authCubit = context.read<AuthCubit>();

                  Show.showLoading(context);
                  authCubit.signOutWithGoogle(onError: (error) {
                    Show.snackbar(context, error);
                  });
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
