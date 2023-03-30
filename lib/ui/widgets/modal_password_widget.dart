import 'package:flutter/material.dart';
import 'package:my_password_app/extensions/string_extension.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';

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
  final _passwordConfig = {
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

  int passwordLength = 10;

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final disableGeneratePassword = _passwordConfig.entries.every(
      (element) => element.value == false,
    );

    final disableSavePassword = [
      _nameController,
      _passwordController,
    ].any(
      (element) => element.text.isNullEmpty,
    );

    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets + EdgeInsets.all(KSize.s16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: "Name",
            ),
            onChanged: (val) {
              setState(() {});
            },
          ),
          SpaceWidget.verti16,
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              hintText: "Password",
            ),
            onChanged: (val) {
              setState(() {});
            },
          ),
          SpaceWidget.verti24,
          Row(
            children: [
              ..._passwordConfig.entries.map(
                (e) => Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
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
                        e.key,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  passwordLength--;
                  setState(() {});
                },
                icon: Icon(Icons.remove),
              ),
              Text('$passwordLength'),
              IconButton(
                onPressed: () {
                  passwordLength++;
                  setState(() {});
                },
                icon: Icon(Icons.add),
              ),
              Expanded(
                child: ElevatedButton(
                  child: Text("Generate random password"),
                  onPressed: disableGeneratePassword
                      ? null
                      : () {
                          final temp = GeneratePassword.getRandomString(
                            length: passwordLength,
                            letter: _passwordConfig["letter"]!,
                            number: _passwordConfig["number"]!,
                            symbol: _passwordConfig["symbol"]!,
                          );
                          _passwordController.text = temp;
                          setState(() {});
                        },
                ),
              ),
            ],
          ),
          SpaceWidget.verti24,
          ElevatedButton(
            child: Text("Save"),
            onPressed: disableSavePassword
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
    );
  }
}
