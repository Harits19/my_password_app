import 'package:flutter/material.dart';
import 'package:my_password_app/core/models/password_application_model.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:my_password_app/ui/widgets/checkbox_widget.dart';
import 'package:my_password_app/ui/widgets/elevated_button_widget.dart';
import 'package:my_password_app/ui/widgets/text_field_widget.dart';

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
  bool _letter = true, _symbol = true, _number = true;
  late final _nameController = TextEditingController(text: widget.name);
  late final _passwordController = TextEditingController(text: widget.password);

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  bool get _disableGeneratePassword => [
        _letter,
        _number,
        _symbol,
      ].every((element) => element == false);

  bool get _disableSavePassword => [
        _nameController,
        _passwordController,
      ].any((element) => element.text.isEmpty);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: KSize.edgeMedium, vertical: KSize.edgeLarge * 2),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFieldWidget(
              hintText: 'Nama Aplikasi',
              controller: _nameController,
              onChanged: (val) {
                setState(() {});
              },
            ),
            TextFieldWidget(
              hintText: 'Password',
              controller: _passwordController,
              onChanged: (val) {
                setState(() {});
              },
            ),
            KSize.verticalSmall,
            Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CheckboxWidget(
                    text: 'Number',
                    value: _number,
                    onChanged: (newValue) {
                      _number = newValue;
                      setState(() {});
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxWidget(
                    text: 'Letter',
                    value: _letter,
                    onChanged: (newValue) {
                      _letter = newValue;
                      setState(() {});
                      print(_letter);
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxWidget(
                    text: 'Symbol',
                    value: _symbol,
                    onChanged: (newValue) {
                      _symbol = newValue;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
            ElevatedButtonWidget(
                text: 'Generate Random Password',
                onPressedParam: _disableGeneratePassword
                    ? null
                    : () {
                        final temp = GeneratePassword.getRandomString(
                            letter: _letter, number: _number, symbol: _symbol);
                        _passwordController.text = temp;

                        setState(() {});
                        print(temp);
                      }),
            KSize.verticalSmall,
            ElevatedButtonWidget(
              text: 'Simpan',
              onPressedParam: _disableSavePassword
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
            KSize.horizontalLarge,
            KSize.horizontalLarge,
          ],
        ),
      ),
    );
  }
}
