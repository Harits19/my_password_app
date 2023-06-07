import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/extensions/context_extension.dart';
import 'package:my_password_app/ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/home/views/drawer_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/pages/views/floating_button_drawer.dart';
import 'package:my_password_app/ui/widgets/widget_util.dart';

class SignInPage extends ConsumerStatefulWidget {
  static const routeName = "/sign-in";
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  bool forceUsePassword = false;

  @override
  void initState() {
    super.initState();
    ref.listenManual(
        signInProvider.select((value) => value.googleSignInAccount),
        (previous, next) {
      next.when(
        loading: () => WidgetUtil.showLoading(),
        error: (error, stack) {
          WidgetUtil.safePop();
          print(error);
          WidgetUtil.showError(error, stackTrace: stack);
        },
        data: (data) {
          if (data != null) {
            context.popAll(HomePage());
          } else {
            WidgetUtil.safePop();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: DrawerView(),
      floatingActionButton: FloatingButtonDrawer(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Spacer(),
              Image.asset(
                KAssets.letterIconAppLight,
              ),
              Spacer(),
              ElevatedButton(
                child: Text('Login/Register with Google'),
                onPressed: () async {
                  ref.read(signInProvider.notifier).signIn();
                },
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
