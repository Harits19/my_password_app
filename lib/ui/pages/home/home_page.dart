import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_locale.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _AppBarView(),
      drawer: _DrawerView(),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(KSize.s16),
        child: Column(
          children: [
            ...List.generate(
              [].length,
              (index) {
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerView extends StatelessWidget {
  const _DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: EdgeInsets.all(KSize.s16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("language".tr()),
            DropdownButton<Locale>(
              value: EasyLocalization.of(context)?.currentLocale,
              isExpanded: true,
              items: [
                ...KLocale.values.map(
                  (e) => DropdownMenuItem(
                    value: e.value,
                    onTap: () {
                      EasyLocalization.of(context)?.setLocale(e.value);
                    },
                    child: Text(
                      e.toString(),
                    ),
                  ),
                ),
              ],
              onChanged: (val) {},
            ),
            KSize.verti16,
            ElevatedButton(
              child: Text('Backup to Google Drive'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Restore from Google Drive'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text(
                "signOutGoogle".tr(),
              ),
              onPressed: () {
                ShowHelper.showLoading(context);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AppBarView extends StatelessWidget implements PreferredSizeWidget {
  _AppBarView({Key? key}) : super(key: key);

  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.nightlight),
        )
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
