import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/app.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';
import 'package:my_password_app/core/utils/my_print.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/pages/splash/splash_page.dart';
import 'package:my_password_app/ui/widgets/loading_widget.dart';
import 'package:my_password_app/ui/widgets/snackbar_widget.dart';
import 'package:my_password_app/ui/widgets/widget_util.dart';

class GuardScreen extends ConsumerStatefulWidget {
  const GuardScreen({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  ConsumerState<GuardScreen> createState() => _HandleTimeOutWidgetState();
}

class _HandleTimeOutWidgetState extends ConsumerState<GuardScreen> {
  @override
  void initState() {
    super.initState();
    ref.listenManual(
        signInProvider.select((value) => value.googleSignInAccount),
        (previous, next) {
      final context = navigatorKey.currentContext;
      if (context == null) return;
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
          myPrint('onReceive data google account $data');
          if (data != null) {
            context.popAll(HomePage());
          } else {
            context.push(SplashPage());
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    void _onInteraction() {
      ref.read(signInProvider.notifier).restartTimer();
    }

    return Listener(
      child: widget.child,
      onPointerCancel: (_) => _onInteraction(),
      onPointerDown: (_) => _onInteraction(),
      onPointerHover: (_) => _onInteraction(),
      onPointerMove: (_) => _onInteraction(),
      onPointerPanZoomEnd: (_) => _onInteraction(),
      onPointerPanZoomStart: (_) => _onInteraction(),
      onPointerPanZoomUpdate: (_) => _onInteraction(),
      onPointerSignal: (_) => _onInteraction(),
      onPointerUp: (_) => _onInteraction(),
    );
  }
}
