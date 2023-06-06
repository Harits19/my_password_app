import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/extensions/string_extension.dart';
import 'package:my_password_app/models/password_model.dart';
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
  late final passwordModel = widget.passwordModel;

  @override
  Widget build(BuildContext context) {
    PopupMenuButton;
    return Column(
      children: [
        ListTile(
          trailing: Builder(builder: (context) {
            return InkWell(
              borderRadius: BorderRadius.circular(24 / 2),
              child: Icon(
                Icons.more_vert,
                size: 24,
              ),
              onTap: () {
                final RenderBox button =
                    context.findRenderObject()! as RenderBox;
                final RenderBox overlay = Navigator.of(context)
                    .overlay!
                    .context
                    .findRenderObject()! as RenderBox;

                final offset = Offset(0, button.size.height);

                final RelativeRect position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(offset, ancestor: overlay),
                    button.localToGlobal(button.size.bottomRight(offset),
                        ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );
                showMenu(
                  context: context,
                  position: position,
                  items: [
                    PopupMenuItem(
                      value: 1,
                      child: Text('1'),
                    )
                  ],
                );
              },
            );
          }),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            passwordModel.name,
          ),
          subtitle: Text(
            passwordModel.email ?? '',
          ),
        ),
        if (false)
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
                    FlutterClipboard.copy(passwordModel.password ?? "").then(
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
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({
    required this.name,
  });

  final String? name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                name ?? '',
              ),
            ),
            IconButton(
              onPressed: () {},
              splashRadius: 16,
              visualDensity: VisualDensity.compact,
              iconSize: 16,
              icon: Icon(
                Icons.copy,
              ),
            )
          ],
        ),
      ),
    );
  }
}
