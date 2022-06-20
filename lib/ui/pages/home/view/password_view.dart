import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:my_password_app/konstan/k_style.dart';
import 'package:my_password_app/ui/helper/show.dart';
import 'package:easy_localization/easy_localization.dart';

class PasswordView extends StatefulWidget {
  PasswordView({
    Key? key,
    required this.password,
    required this.name,
  }) : super(key: key);

  final String password;
  final String name;

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
            ? widget.password.toObscureText()
            : widget.password;
    return Card(
      color: _isDelete ? Colors.red : null,
      child: InkWell(
        child: Column(
          children: [
            ListTile(
              title: Text(title, style: KStyle.h1),
              subtitle: Text(
                subtitle,
                style: KStyle.h2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: KSize.edgeMedium),
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
          onPressed: () {},
        ),
      ),
      KSize.horizontalSmall,
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
      KSize.horizontalSmall,
      Expanded(
        child: ElevatedButton(
          child: Icon(Icons.edit),
          onPressed: () {},
        ),
      ),
      KSize.horizontalSmall,
      Expanded(
        child: ElevatedButton(
          child: Icon(Icons.copy),
          onPressed: () {
            FlutterClipboard.copy(widget.password)
                .then((value) => Show.snackbar(context, 'successCopy'.tr()));
          },
        ),
      ),
    ];
  }
}
