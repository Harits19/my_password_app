import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/home_notifier.dart';
import 'package:my_password_app/ui/pages/home/views/drawer_view.dart';
import 'package:my_password_app/ui/pages/home/views/floating_button_view.dart';
import 'package:my_password_app/ui/pages/home/views/password_view.dart';
import 'package:my_password_app/ui/widgets/text_field_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomeV2PageState();
}

class _HomeV2PageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final listPassword = ref.watch(
        homeNotifier.select((value) => value.passwords.valueOrNull ?? []));
    return Scaffold(
      floatingActionButton: FloatingButtonView(),
      endDrawer: DrawerView(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(KSize.s16),
          children: [
            TextFieldWidget(
              decoration: InputDecoration(
                hintText: 'Search',
              ),
            ),
            SizedBox(
              height: KSize.s16,
            ),
            ...List.generate(
              listPassword.length,
              (index) {
                return Padding(
                  key: ObjectKey(listPassword[index]),
                  padding: const EdgeInsets.symmetric(vertical: KSize.s4),
                  child: PasswordView(
                    passwordModel: listPassword[index],
                    index: index,
                  ),
                );
              },
            ),
            Opacity(
              opacity: 0,
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
