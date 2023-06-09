import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';
import 'package:my_password_app/ui/konstans/k_assets.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/pages/views/floating_button_drawer.dart';
import 'package:my_password_app/ui/widgets/loading_widget.dart';
import 'package:my_password_app/ui/widgets/snackbar_widget.dart';
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
        loading: () => LoadingWidget.dialog(context),
        error: (error, stack) {
          WidgetUtil.safePop(context);
          print(error);
          SnackbarWidget.showError(
            context,
            error,
          );
        },
        data: (data) {
          if (data != null) {
            context.popAll(HomePage());
          } else {
            WidgetUtil.safePop(context);
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
