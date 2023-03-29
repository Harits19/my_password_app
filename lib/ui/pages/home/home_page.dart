import 'package:flutter/material.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/widgets/loading_widget.dart';

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
            Text("Language"),
            
            KSize.verti16,
            ElevatedButton(
              child: Text('Backup to Google Drive'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: Text('Restore from Google Drive'),
              onPressed: () {},
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
