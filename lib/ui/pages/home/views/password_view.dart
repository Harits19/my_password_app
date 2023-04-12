import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/extensions/string_extension.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/core/providers/password/password_notifier.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/views/password_footer_view.dart';
import 'package:my_password_app/ui/widgets/modal_password_widget.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';
import 'package:my_password_app/utils/my_print.dart';

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
  bool _isObscure = true;

  late final passwordModel = widget.passwordModel;
  late final passwordRead = ref.read(passwordProvider.notifier);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onLongPress: () {},
        child: Padding(
          padding: const EdgeInsets.all(KSize.s8),
          child: Column(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  dividerColor: Colors.transparent,
                  expansionTileTheme: ExpansionTileThemeData(
                    textColor: Theme.of(context).textTheme.titleMedium!.color,
                    iconColor: Theme.of(context).unselectedWidgetColor,
                  ),
                ),
                child: ExpansionTile(
                  title: Text(
                    passwordModel.name ?? "",
                  ),
                  subtitle: Text(
                    _isObscure
                        ? passwordModel.password.toObscureText
                        : passwordModel.password ?? "",
                  ),
                  expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                  childrenPadding: const EdgeInsets.all(KSize.s16),
                  children: [Text(passwordModel.note ?? '-')],
                ),
              ),
              PasswordFooterView(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      child: Icon(_isObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye),
                      onPressed: () {
                        _isObscure = !_isObscure;
                        setState(() {});
                      },
                    ),
                  ),
                  SpaceWidget.hori16,
                  Expanded(
                    child: ElevatedButton(
                      child: Icon(Icons.edit),
                      onPressed: () {
                        ModalPasswordWidget.show(
                          value: passwordModel,
                          context: context,
                          onPressedSave: (val) async {
                            myPrint(val.name);
                            myPrint(val.password);
                            myPrint(passwordModel.id);
                            myPrint(val.id);
                            ref.read(passwordProvider.notifier).update(val);
                            Navigator.pop(context);
                          },
                        );
                      },
                    ),
                  ),
                  SpaceWidget.hori16,
                  Expanded(
                    child: ElevatedButton(
                      child: Icon(Icons.copy),
                      onPressed: () {
                        FlutterClipboard.copy(passwordModel.password ?? "")
                            .then(
                          (value) => SnackBarWidget.show(
                            context,
                            'Success Copy',
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
