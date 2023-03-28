import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/sign_in/sign_in_notifier.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';

class HomeV2Page extends ConsumerStatefulWidget {
  const HomeV2Page({super.key});

  @override
  ConsumerState<HomeV2Page> createState() => _HomeV2PageState();
}

class _HomeV2PageState extends ConsumerState<HomeV2Page> {
  @override
  Widget build(BuildContext context) {
    final signInWatch = ref.watch(signInProvider);
    final signInRead = ref.read(signInProvider.notifier);
    print(signInWatch.useFingerprint);
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
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
      ),
      body: SafeArea(
        child: Column(),
      ),
    );
  }
}
