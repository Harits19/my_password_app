import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/core/viewmodels/auth_model.dart';

import 'package:get/get.dart';
import 'package:my_password_app/cubit/password_cubit.dart';
import 'package:my_password_app/ui/page/splash_view.dart';
import 'package:my_password_app/utils/app_bloc_observer.dart';
import 'package:my_password_app/utils/k_injection.dart';
import 'package:my_password_app/utils/k_log.dart';

void main() async {
  log(DateTime.now());
  await setupDepedencyInjection();
  BlocOverrides.runZoned(() {
    runApp(
      App(),
    );
  }, blocObserver: AppBlocObserver());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PasswordCubit()..getDataAuth(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        home: SplashView(),
        theme: ThemeData.dark(),
      ),
    );
  }
}
