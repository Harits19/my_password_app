import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/cubits/auth/auth_cubit.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/cubits/theme/theme_cubit.dart';
import 'package:my_password_app/routes.dart';
import 'package:my_password_app/ui/app_ui/app_ui.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/widgets/blur_widget.dart';
import 'package:my_password_app/ui/widgets/handle_time_out_widget.dart';

// TODO mengubah menjadi aplikasi full offiline
// TODO app can send file backup via bluetooth
// TODO

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => PasswordCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return HandleTimeOutWidget(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: SignInPage.routeName,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              theme: () {
                if (state is ThemeDarkMode)
                  return MyTheme.dark;
                else
                  return MyTheme.light;
              }(),
              routes: {
                ...kRoute.map((key, value) => MapEntry(key, (_) => value))
              },
              
            ),
          );
        },
      ),
    );
  }
}
