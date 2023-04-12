import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/providers/password/password_notifier.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/views/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/views/floating_button_view.dart';
import 'package:my_password_app/ui/pages/home/views/password_view.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomeV2PageState();
}

class _HomeV2PageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final passwordWatch = ref.watch(passwordProvider);
    return Scaffold(
      floatingActionButton: FloatingButtonView(),
      endDrawer: DrawerView(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(KSize.s16),
          children: [
            ...List.generate(
              passwordWatch.length,
              (index) {
                return Padding(
                  key: ObjectKey(passwordWatch[index]),
                  padding: const EdgeInsets.symmetric(vertical: KSize.s4),
                  child: PasswordView(
                    passwordModel: passwordWatch[index],
                    index: index,
                  ),
                );
              },
            ),
            Visibility(
              visible: false,
              child: FloatingActionButton(
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
