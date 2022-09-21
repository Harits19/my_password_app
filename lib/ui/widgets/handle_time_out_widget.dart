import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';

class HandleTimeOutWidget extends StatelessWidget {
  const HandleTimeOutWidget({
    Key? key,
    this.child,
  }) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      child: child,
      onPointerCancel: (_) => _onInteraction(context),
      onPointerDown: (_) => _onInteraction(context),
      onPointerHover: (_) => _onInteraction(context),
      onPointerMove: (_) => _onInteraction(context),
      onPointerPanZoomEnd: (_) => _onInteraction(context),
      onPointerPanZoomStart: (_) => _onInteraction(context),
      onPointerPanZoomUpdate: (_) => _onInteraction(context),
      onPointerSignal: (_) => _onInteraction(context),
      onPointerUp: (_) => _onInteraction(context),
    );
  }

  void _onInteraction(BuildContext context) {
    final passwordRead = context.read<PasswordCubit>();
    passwordRead.restartTimer();
  }
}
