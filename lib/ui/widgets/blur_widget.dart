import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';

class BlurInactiveWidget extends StatefulWidget {
  const BlurInactiveWidget({
    Key? key,
    required this.child,
  }) : super(key: key);
  final Widget? child;

  @override
  State<BlurInactiveWidget> createState() => _BlurInactiveWidgetState();
}

class _BlurInactiveWidgetState extends State<BlurInactiveWidget>
    with WidgetsBindingObserver {
  bool _shouldBlur = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final state = WidgetsBinding.instance.lifecycleState;
    if (state == null) return;
    _updateBlurState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _updateBlurState(state);
  }

  void _updateBlurState(AppLifecycleState state) async {
    setState(() {
      _shouldBlur = state == AppLifecycleState.inactive ||
          state == AppLifecycleState.paused;
    });

    if (!_shouldBlur) {
      final passwordRead = context.read<PasswordCubit>();
      passwordRead.resetAuthentication();
    }
  }

  @override
  Widget build(BuildContext context) {
    print('is blur now');
    return Stack(
      children: [
        widget.child ?? SizedBox(),
        if (_shouldBlur)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.grey.shade200.withOpacity(0.5),
            ),
          ),
      ],
    );
  }
}
