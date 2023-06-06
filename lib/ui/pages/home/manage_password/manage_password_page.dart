import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/models/password_model.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';
import 'package:my_password_app/ui/pages/home/home_notifier.dart';
import 'package:my_password_app/ui/pages/home/manage_password/manage_password_notifier.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';
import 'package:my_password_app/ui/widgets/text_field_widget.dart';
import 'package:my_password_app/ui/widgets/widget_util.dart';

class ManagePasswordPage extends ConsumerStatefulWidget {
  ManagePasswordPage({
    Key? key,
    this.value,
  }) : super(key: key) {}

  final PasswordModel? value;

  @override
  ConsumerState<ManagePasswordPage> createState() => _ManagePasswordPageState();

  static Future<void> show({
    required BuildContext context,
    PasswordModel? value,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return ManagePasswordPage(
          value: value,
        );
      },
    );
  }
}

class _ManagePasswordPageState extends ConsumerState<ManagePasswordPage> {
  final passwordConfig = {
    ("letter"): true,
    ("symbol"): true,
    ("number"): true,
  };

  int passwordLength = 10;

  @override
  void initState() {
    super.initState();
    WidgetUtil.checkWidget(() {
      ref.read(managePasswordNotifier.notifier).init(widget.value);
    });
    ref.listenManual(
      managePasswordNotifier.select((value) => value.result),
      (previous, next) {
        next.when(
          loading: () => WidgetUtil.showLoading(),
          error: (error, stackTrace) {
            WidgetUtil.safePop();
            WidgetUtil.safePop();
            WidgetUtil.showError(error, stackTrace);
          },
          data: (data) {
            if (data.isEmpty) return;
            WidgetUtil.safePop();
            WidgetUtil.safePop();
            WidgetUtil.showSuccess(data);
            ref.read(homeNotifier.notifier).getListPassword();
          },
        );
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final disableGeneratePassword = passwordConfig.entries.every(
      (element) => element.value == false,
    );

    final disableSavePassword = [].any(
      (element) => element.text.isNullEmpty,
    );
    final onChanged = (String val) {
      setState(() {});
    };

    final mpWatch = ref.watch(managePasswordNotifier);
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: MediaQuery.of(context).viewInsets + EdgeInsets.all(KSize.s16),
        children: <Widget>[
          TextFieldWidget(
            mandatory: true,
            controller: mpWatch.name,
            decoration: InputDecoration(
              hintText: "Name",
            ),
            onChanged: onChanged,
          ),
          SpaceWidget.verti16,
          TextFieldWidget(
            controller: mpWatch.email,
            decoration: InputDecoration(
              hintText: "Email or Username",
            ),
          ),
          SpaceWidget.verti16,
          TextFieldWidget(
            mandatory: true,
            controller: mpWatch.password,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Password",
            ),
          ),
          SpaceWidget.verti16,
          TextFieldWidget(
            maxLines: 8,
            controller: mpWatch.note,
            decoration: InputDecoration(hintText: 'Note...'),
          ),
          SpaceWidget.verti24,
          Row(
            children: [
              ...passwordConfig.entries.map(
                (e) => Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: e.value,
                        onChanged: (newValue) {
                          if (newValue == null) return;
                          passwordConfig[e.key] = newValue;
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
                            letter: passwordConfig["letter"]!,
                            number: passwordConfig["number"]!,
                            symbol: passwordConfig["symbol"]!,
                          );
                          mpWatch.password.text = temp;
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
                    if (_formKey.currentState!.validate()) {
                      if (mpWatch.selectedPasswordModel == null) {
                        ref.read(managePasswordNotifier.notifier).addPassword();
                      } else {
                        ref
                            .read(managePasswordNotifier.notifier)
                            .updatePassword();
                      }
                    }
                  },
          ),
          if (widget.value != null)
            TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Are you sure to delete?'),
                      actions: [
                        ElevatedButton(
                          child: Text('Yes'),
                          onPressed: () {
                            Navigator.pop(context);
                            ref
                                .read(managePasswordNotifier.notifier)
                                .deletePassword();
                          },
                        ),
                        ElevatedButton(
                          child: Text('No'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Delete',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ))
        ],
      ),
    );
  }
}
