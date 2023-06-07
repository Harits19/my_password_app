import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_page.dart';

class PasswordView extends ConsumerStatefulWidget {
  PasswordView({
    Key? key,
    required this.passwordModel,
    required this.index,
  }) : super(key: key);

  final PasswordModel passwordModel;
  final int index;

  @override
  ConsumerState<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends ConsumerState<PasswordView> {
  late final passwordModel = widget.passwordModel;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );
    return Column(
      children: [
        Card(
          shape: shape,
          child: ListTile(
            shape: shape,
            onTap: () {
              ManagePasswordPage.show(
                context: context,
                managePasswordPage: ManagePasswordPage(
                  value: passwordModel,
                  isReadOnly: true,
                ),
              );
            },
            title: Text(
              passwordModel.name,
            ),
            subtitle: Text(
              passwordModel.email ?? '',
            ),
          ),
        ),
      ],
    );
  }
}
