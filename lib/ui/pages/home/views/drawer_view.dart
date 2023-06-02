import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';
import 'package:my_password_app/ui/widgets/text_field_password_widget.dart';

class DrawerView extends ConsumerStatefulWidget {
  const DrawerView({
    super.key,
  });

  @override
  ConsumerState<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends ConsumerState<DrawerView> {
  String oldPassword = '', newPassword = '', confirmNewPassword = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: ListView(
            padding: const EdgeInsets.all(KSize.s16),
            children: [
              SpaceWidget.verti24,
              SpaceWidget.verti24,
              Divider(),
              SpaceWidget.verti24,
              Row(
                children: [
                  Expanded(
                    child: Text('Unlock with Fingerprint'),
                  ),
                  Switch(
                    value: false,
                    onChanged: (val) async {},
                  )
                ],
              ),
              SpaceWidget.verti16,
              DropdownButton(
                isExpanded: true,
                value: ThemeMode.dark,
                items: [
                  ...ThemeMode.values.map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e.name),
                    ),
                  )
                ],
                onChanged: (val) {},
              ),
              TextButton(
                onPressed: () {},
                child: Text('Export'),
              ),
              TextButton(
                onPressed: () async {},
                child: Text('Import'),
              ),
              SpaceWidget.verti24,
              SpaceWidget.verti24,
              Divider(),
              SpaceWidget.verti24,
              TextFieldPasswordWidget(
                decoration: InputDecoration(
                  labelText: 'Current Master Password',
                ),
                onChanged: (val) {
                  oldPassword = val;
                  setState(() {});
                },
              ),
              TextFieldPasswordWidget(
                decoration: InputDecoration(
                  labelText: 'New Master Password',
                ),
                onChanged: (val) {
                  newPassword = val;
                  setState(() {});
                },
              ),
              TextFieldPasswordWidget(
                decoration: InputDecoration(
                  labelText: 'Confirm Master Password',
                ),
                onChanged: (val) {
                  confirmNewPassword = val;
                  setState(() {});
                },
              ),
              SpaceWidget.hori16,
              TextButton(
                child: Text('Change Password'),
                onPressed: () async {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
