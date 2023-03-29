import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/core/providers/theme/theme_notifier.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';

class DrawerView extends ConsumerStatefulWidget {
  const DrawerView({
    super.key,
  });

  @override
  ConsumerState<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends ConsumerState<DrawerView> {
  @override
  Widget build(BuildContext context) {
    final signInWatch = ref.watch(signInProvider);
    final signInRead = ref.read(signInProvider.notifier);
    final themeRead = ref.read(themeProvider.notifier);
    final themeWatch = ref.watch(themeProvider);
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
              ),
              KSize.verti16,
              DropdownButton(
                isExpanded: true,
                value: themeWatch,
                items: [
                  ...ThemeMode.values.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                ],
                onChanged: (val) {
                  if (val == null) return;
                  themeRead.setTheme(val);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
