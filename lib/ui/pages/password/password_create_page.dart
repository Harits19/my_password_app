import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/translations/translation.dart';
import 'package:my_password_app/cubits/password/password_cubit.dart';
import 'package:my_password_app/ui/app_ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/home_page.dart';

class PasswordCreatePage extends StatefulWidget {
  static const routeName = '/password-create';

  const PasswordCreatePage({Key? key}) : super(key: key);

  @override
  State<PasswordCreatePage> createState() => _PasswordCreatePageState();
}

class _PasswordCreatePageState extends State<PasswordCreatePage> {
  final _formKey = GlobalKey<FormState>();

  String? _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(KSize.s16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              _PasswordWidget(
                hint: 'Password',
                onChanged: (val) {
                  _password = val;
                  setState(() {});
                },
              ),
              _PasswordWidget(
                hint: 'Password Confirmation',
                validator: (val) {
                  if (_password != val) {
                    return 'Password ' + Tr.notMatch.value(context);
                  }
                  return null;
                },
              ),
              Spacer(),
              ElevatedButton(
                child: Text(
                  Tr.save.value(context),
                ),
                onPressed: () async {
                  final isValidated = _formKey.currentState!.validate();
                  if (isValidated) {
                    final passwordRead = context.read<PasswordCubit>();
                    await passwordRead.setAppPassword(_password!);
                    context.popAll(HomePage.routeName);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _PasswordWidget extends StatefulWidget {
  const _PasswordWidget({
    Key? key,
    required this.hint,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final String hint;
  final ValueChanged<String?>? onChanged;
  final String? Function(String?)? validator;

  @override
  State<_PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<_PasswordWidget> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _isObscure,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure
                ? Icons.remove_red_eye_rounded
                : Icons.remove_red_eye_outlined,
          ),
          onPressed: () {
            _isObscure = !_isObscure;
            setState(() {});
          },
        ),
        labelText: widget.hint,
      ),
      validator: (val) {
        if (val.isNullEmpty) {
          return widget.hint + ' ' + Tr.cantBeEmpty.value(context);
        }
        if (widget.validator != null) {
          return widget.validator!(val);
        }
        return null;
      },
    );
  }
}
