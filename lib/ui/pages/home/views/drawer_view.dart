import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/password/password_notifier.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/core/providers/theme/theme_notifier.dart';
import 'package:my_password_app/extensions/context_extension.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/views/confirm_import_view.dart';
import 'package:my_password_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';

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
    final passwordRead = ref.read(passwordProvider.notifier);
    final themeRead = ref.read(themeProvider.notifier);
    final themeWatch = ref.watch(themeProvider);

    ref.listen(
      signInProvider,
      (prev, next) {
        if (!next.isLoggedIn) {
          print('log out');
          context.popAll(SignInPage());
        }
      },
    );
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
              SpaceWidget.verti16,
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
              ),
              TextButton(
                onPressed: () {
                  passwordRead.export();
                },
                child: Text('Export'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final isConfirmed = await ConfirmImportView.show(context);
                    if (!isConfirmed) return;
                    final imported = await passwordRead.import();
                    if (!imported) return;
                    signInRead.signOut();
                  } catch (e) {
                    var message = 'Unexpected error';
                    if (kDebugMode) {
                      message = e.toString();
                    }
                    SnackBarWidget.show(context, message);
                  }
                },
                child: Text('Import'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
