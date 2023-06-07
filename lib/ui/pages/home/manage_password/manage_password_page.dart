import 'package:clipboard/clipboard.dart';
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
    this.isReadOnly = false,
  }) : super(key: key) {}

  final PasswordModel? value;
  final bool isReadOnly;

  @override
  ConsumerState<ManagePasswordPage> createState() => _ManagePasswordPageState();

  static Future<void> show({
    required BuildContext context,
    required ManagePasswordPage managePasswordPage,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return managePasswordPage;
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
  late final isReadOnly = widget.isReadOnly;

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
    final mpWatch = ref.watch(managePasswordNotifier);

    Widget copy(String val) {
      return IconButton(
        icon: Icon(Icons.copy),
        onPressed: () {
          if (val.isNotEmpty) {
            FlutterClipboard.copy(val);
            WidgetUtil.showSuccess('Success copy');
          } else {
            WidgetUtil.showError('Empty value', StackTrace.current);
          }
        },
      );
    }

    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        padding: MediaQuery.of(context).viewInsets + EdgeInsets.all(KSize.s16),
        children: <Widget>[
          TextFieldWidget(
            readOnly: isReadOnly,
            mandatory: true,
            controller: mpWatch.name,
            decoration: InputDecoration(
              hintText: "Name",
              suffixIcon: copy(mpWatch.name.text),
            ),
          ),
          SpaceWidget.verti16,
          TextFieldWidget(
            readOnly: isReadOnly,
            controller: mpWatch.email,
            decoration: InputDecoration(
              hintText: "Email or Username",
              suffixIcon: copy(mpWatch.email.text),
            ),
          ),
          SpaceWidget.verti16,
          TextFieldWidget(
            readOnly: isReadOnly,
            mandatory: true,
            controller: mpWatch.password,
            decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: copy(mpWatch.password.text),
            ),
          ),
          SpaceWidget.verti16,
          TextFieldWidget(
            readOnly: isReadOnly,
            maxLines: 8,
            controller: mpWatch.note,
            decoration: InputDecoration(
              hintText: 'Note...',
              suffixIcon: copy(mpWatch.note.text),
            ),
          ),
          if (!isReadOnly) ...[
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
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (mpWatch.selectedPasswordModel == null) {
                    ref.read(managePasswordNotifier.notifier).addPassword();
                  } else {
                    ref.read(managePasswordNotifier.notifier).updatePassword();
                  }
                }
              },
            ),
          ],
          if (widget.value != null && isReadOnly)
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.red,
                    ),
                    child: Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
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
                  ),
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(),
                    child: Text(
                      'Edit',
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      ManagePasswordPage.show(
                        context: context,
                        managePasswordPage: ManagePasswordPage(
                          value: widget.value,
                          isReadOnly: false,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
