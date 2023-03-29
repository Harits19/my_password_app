import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';

class DrawerView extends ConsumerWidget {
  const DrawerView({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final signInWatch = ref.watch(signInProvider);
    final signInRead = ref.read(signInProvider.notifier);
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSize.s16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Unlock with Fingerprint'),
                  ),
                  Switch(
                    value: signInWatch.useFingerprint,
                    onChanged: (val) async {
                      final isAuthenticated =
                          await signInRead.authWithBiometric(context);
                      if (isAuthenticated) {
                        signInRead.toggleUseFingerprint();
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
