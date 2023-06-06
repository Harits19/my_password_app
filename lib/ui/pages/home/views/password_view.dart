import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/extensions/string_extension.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/home_notifier.dart';
import 'package:my_password_app/ui/pages/home/views/password_footer_view.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_page.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';

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
  bool isObscure = true;

  bool isExpanded = false;

  late final passwordModel = widget.passwordModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure to delete ${passwordModel.name}?'),
              actions: [
                ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
        onTap: () {
          isExpanded = !isExpanded;
          setState(() {});
        },
        child: Padding(
          padding: const EdgeInsets.all(KSize.s8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                trailing: Icon(isExpanded
                    ? Icons.arrow_drop_down_circle
                    : Icons.arrow_drop_down),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      passwordModel.name ?? "",
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    if (passwordModel.email.isNotNullEmpty) ...[
                      SpaceWidget.verti8,
                      Text(
                        passwordModel.email ?? "",
                      ),
                    ],
                    SpaceWidget.verti8,
                  ],
                ),
                subtitle: Text(
                  isObscure
                      ? passwordModel.password.toObscureText
                      : passwordModel.password ?? "",
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.all(KSize.s16),
                  child: Text(passwordModel.note ?? '-'),
                ),
              PasswordFooterView(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Icon(Icons.edit),
                      onPressed: () async {
                        await ManagePasswordPage.show(
                          value: passwordModel,
                          context: context,
                        );
                      },
                    ),
                  ),
                  SpaceWidget.hori16,
                  Expanded(
                    child: ElevatedButton(
                      child: Text(
                        'Copy Password',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () {
                        FlutterClipboard.copy(passwordModel.password ?? "")
                            .then(
                          (value) => SnackBarWidget.show(
                            context,
                            'Success Copy Password',
                          ),
                        );
                      },
                    ),
                  ),
                  if (passwordModel.email.isNotNullEmpty) ...[
                    SpaceWidget.hori16,
                    Expanded(
                      child: ElevatedButton(
                        child: Text(
                          'Copy Email',
                          textAlign: TextAlign.center,
                        ),
                        onPressed: () {
                          FlutterClipboard.copy(passwordModel.email ?? "").then(
                            (value) => SnackBarWidget.show(
                              context,
                              'Success Copy Email',
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
