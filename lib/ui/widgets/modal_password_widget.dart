import 'package:flutter/material.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:easy_localization/easy_localization.dart';

class ModalPasswordWidget extends StatefulWidget {
  ModalPasswordWidget({
    Key? key,
    this.value,
    this.onPressSave,
  }) : super(key: key) {}

  final PasswordModel? value;
  final ValueChanged<PasswordModel>? onPressSave;

  @override
  State<ModalPasswordWidget> createState() => _ModalPasswordWidgetState();

  static Future<void> show({
    required BuildContext context,
    PasswordModel? value,
    required ValueChanged<PasswordModel>? onPressedSave,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      enableDrag: false,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ModalPasswordWidget(
          value: value,
          onPressSave: onPressedSave,
        );
      },
    );
  }
}

class _ModalPasswordWidgetState extends State<ModalPasswordWidget> {
  var _passwordConfig = {
    ("letter"): true,
    ("symbol"): true,
    ("number"): true,
  };
  late final _nameController = TextEditingController(
    text: widget.value?.name,
  );
  late final _passwordController = TextEditingController(
    text: widget.value?.password,
  );

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
      ].any((element) => element.text.isNullEmpty);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: EdgeInsets.all(KSize.s16),
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
            KSize.verti16,
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                hintText: tr("password"),
              ),
              onChanged: (val) {
                setState(() {});
              },
            ),
            KSize.verti24,
            Row(
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
                      }),
            KSize.verti24,
            ElevatedButton(
              child: Text(tr("save")),
              onPressed: _disableSavePassword
                  ? null
                  : () {
                      if (widget.onPressSave == null) return;
                      widget.onPressSave!(
                        PasswordModel(
                          id: widget.value?.id,
                          name: _nameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
            ),
          ],
        ),
      ),
    );
  }
}
