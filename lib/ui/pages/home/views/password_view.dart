import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/core/providers/password/password_notifier.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:my_password_app/ui/widgets/modal_password_widget.dart';
import 'package:my_password_app/ui/widgets/snack_bar_widget.dart';

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
  bool _isDelete = false;
  late final passwordModel = widget.passwordModel;
  late final passwordRead = ref.read(passwordProvider.notifier);

  @override
  Widget build(BuildContext context) {
    final title = _isDelete
        ? '${"deleteData".tr()} ${passwordModel.name}'
        : passwordModel.name;
    final subtitle = _isDelete
        ? "areYouSure".tr()
        : _isObscure
            ? passwordModel.password.toObscureText
            : passwordModel.password;
    return Card(
      color: _isDelete ? Colors.red : null,
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(KSize.s8),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  title ?? "",
                ),
                subtitle: Text(
                  subtitle ?? "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KSize.s8),
                child: Row(
                  children: _isDelete ? _deleteButton() : _toolWidget(),
                ),
              ),
            ],
          ),
        ),
        onLongPress: () {
          _isDelete = true;
          setState(() {});
        },
      ),
    );
  }

  void _handlerEdit() async {
    ModalPasswordWidget.show(
      value: passwordModel,
      context: context,
      onPressedSave: (val) async {
        print(val.name);
        print(val.password);
        print(passwordModel.id);
        print(val.id);
        ref.read(passwordProvider.notifier).update(val);
        context.pop();
      },
    );
  }

  List<Widget> _deleteButton() {
    return [
      Expanded(
        child: ElevatedButton(
          child: Text('yes'.tr()),
          onPressed: () {
            _isDelete = false;
            setState(() {});
            passwordRead.remove(passwordModel.id);
          },
        ),
      ),
      KSize.hori8,
      Expanded(
        child: ElevatedButton(
          child: Text('no'.tr()),
          onPressed: () {
            _isDelete = false;
            setState(() {});
          },
        ),
      ),
    ];
  }

  List<Widget> _toolWidget() {
    return [
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
      KSize.hori16,
      Expanded(
        child: ElevatedButton(
          child: Icon(Icons.edit),
          onPressed: _handlerEdit,
        ),
      ),
      KSize.hori16,
      Expanded(
        child: ElevatedButton(
          child: Icon(Icons.copy),
          onPressed: () {
            FlutterClipboard.copy(passwordModel.password ?? "").then(
                (value) => SnackBarWidget.show(context, 'successCopy'.tr()));
          },
        ),
      ),
    ];
  }
}