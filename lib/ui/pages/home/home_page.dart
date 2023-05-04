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
  String search = '';

  @override
  Widget build(BuildContext context) {
    final passwordWatch = ref.watch(passwordProvider);

    final resultSearch = passwordWatch.where((element) {
      final combineString =
          '${element.email ?? ''} ${element.name ?? ''} ${element.note}';
      return combineString.toLowerCase().contains(search.toLowerCase());
    });

    final showedList =
        (search.isNotEmpty ? resultSearch : passwordWatch).toList();

    return Scaffold(
      floatingActionButton: FloatingButtonView(),
      endDrawer: DrawerView(),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(KSize.s16),
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search',
              ),
              onChanged: (value) {
                search = value;
                setState(() {});
              },
            ),
            SizedBox(
              height: KSize.s16,
            ),
            ...List.generate(
              showedList.length,
              (index) {
                return Padding(
                  key: ObjectKey(showedList[index]),
                  padding: const EdgeInsets.symmetric(vertical: KSize.s4),
                  child: PasswordView(
                    passwordModel: showedList[index],
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
