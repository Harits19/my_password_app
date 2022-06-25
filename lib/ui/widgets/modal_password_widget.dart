import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:easy_localization/easy_localization.dart';

class ModalPasswordWidget extends StatefulWidget {
  ModalPasswordWidget({
    Key? key,
    required this.name,
    required this.password,
    this.onPressSave,
  }) : super(key: key);

  final String? name, password;
  final ValueChanged<PasswordModel>? onPressSave;

  @override
  State<ModalPasswordWidget> createState() => _ModalPasswordWidgetState();
}

class _ModalPasswordWidgetState extends State<ModalPasswordWidget> {
  var _passwordConfig = {
    ("letter"): true,
    ("symbol"): true,
    ("number"): true,
  };
  late final _nameController = TextEditingController(text: widget.name);
  late final _passwordController = TextEditingController(text: widget.password);

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  bool get _disableGeneratePassword =>
      _passwordConfig.entries.every((element) => element.value == false);

  bool get _disableSavePassword => [
        _nameController,
        _passwordController,
      ].any((element) => element.text.isEmpty);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: KSize.s8, vertical: KSize.s16 * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'applicationName'.tr(),
              ),
              onChanged: (val) {
                setState(() {});
              },
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: tr("password"),
              ),
              onChanged: (val) {
                setState(() {});
              },
            ),
            KSize.verti8,
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ..._passwordConfig.entries.map(
                  (e) => Expanded(
                    child: Row(
                      children: [
                        Checkbox(
                          value: e.value,
                          onChanged: (newValue) {
                            if (newValue == null) return;
                            _passwordConfig[e.key] = newValue;
                            setState(() {});
                          },
                        ),
                        Text(
                          tr(e.key),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                child: Text(tr("generateRandomPassword")),
                onPressed: _disableGeneratePassword
                    ? null
                    : () {
                        final temp = GeneratePassword.getRandomString(
                          letter: _passwordConfig["letter"]!,
                          number: _passwordConfig["number"]!,
                          symbol: _passwordConfig["symbol"]!,
                        );
                        _passwordController.text = temp;

                        setState(() {});
                        print(temp);
                      }),
            KSize.verti8,
            ElevatedButton(
              child: Text(tr("save")),
              onPressed: _disableSavePassword
                  ? null
                  : () {
                      if (widget.onPressSave == null) return;
                      widget.onPressSave!(
                        PasswordModel(
                            name: _nameController.text,
                            password: _passwordController.text),
                      );
                    },
            ),
            KSize.hori24,
            KSize.hori24,
          ],
        ),
      ),
    );
  }
}
