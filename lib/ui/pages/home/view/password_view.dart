import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:my_password_app/ui/app_ui/show_helper.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordView extends StatefulWidget {
  PasswordView({
    Key? key,
    this.password,
    this.name,
    this.onTapEdit,
    this.onTapDelete,
  }) : super(key: key);

  final String? password;
  final String? name;
  final VoidCallback? onTapEdit;
  final VoidCallback? onTapDelete;

  @override
  State<PasswordView> createState() => _PasswordViewState();
}

class _PasswordViewState extends State<PasswordView> {
  bool _isObscure = true;
  bool _isDelete = false;

  @override
  Widget build(BuildContext context) {
    final title =
        _isDelete ? '${"deleteData".tr()} ${widget.name}' : widget.name;
    final subtitle = _isDelete
        ? "areYouSure".tr()
        : _isObscure
            ? widget.password.toObscureText
            : widget.password;
    return Card(
      color: _isDelete ? Colors.red : null,
      child: InkWell(
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
                mainAxisSize: MainAxisSize.min,
                children: _isDelete ? _deleteButton() : _toolWidget(),
              ),
            ),
          ],
        ),
        onLongPress: () {
          _isDelete = true;
          setState(() {});
        },
      ),
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
            if (widget.onTapDelete == null) return;
            widget.onTapDelete!();
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
      KSize.hori8,
      Expanded(
        child: ElevatedButton(
          child: Icon(Icons.edit),
          onPressed: widget.onTapEdit,
        ),
      ),
      KSize.hori8,
      Expanded(
        child: ElevatedButton(
          child: Icon(Icons.copy),
          onPressed: () {
            FlutterClipboard.copy(widget.password ?? "").then(
                (value) => ShowHelper.snackbar(context, 'successCopy'.tr()));
          },
        ),
      ),
    ];
  }
}
