import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_password_app/core/models/app_item.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/ui/shared/custom_styles.dart';
import 'package:my_password_app/ui/shared/ui_helpers.dart';
import 'package:my_password_app/ui/widgets/custom_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  bool number = false;
  bool letter = false;
  bool symbol = false;

  String name = '';

  late final getItems;
  late AppModel appModel;

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    appModel = Get.put(AppModel());
    // appModel.removeItem();
    appModel.getItem();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(UIHelper.edgeMedium),
          child: Column(
            children: <Widget>[
              TextFieldWidget(hintText: 'Cari Aplikasi'),
              Expanded(
                child: Obx(
                  () => appModel.items.isEmpty
                      ? Center(
                          child: Text(
                            'Data Not Found',
                            style: CustomStyle.titleStyle,
                          ),
                        )
                      : ListView.builder(
                          itemCount: appModel.items.length,
                          itemBuilder: (context, index) {
                            return buildItemData(
                                name: appModel.items[index].name,
                                password: appModel.items[index].password,
                                onPressed: () {
                                  appModel.removeItem(index: index);
                                });
                          }),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          buildShowModalBottomSheet(context);
          resetValue();
        },
      ),
    );
  }

  void resetValue() {
    name = '';
    number = false;
    letter = false;
    symbol = false;
    passwordController.text = '';
  }

  void setCheckbox({required value, required newValue}) {
    value = newValue;
  }

  Future<void> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: UIHelper.edgeMedium,
                vertical: UIHelper.edgeLarge * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFieldWidget(
                  hintText: 'Nama Aplikasi',
                  onChanged: (value) {
                    name = value;
                    print(name);
                  },
                ),
                TextFieldWidget(
                  hintText: 'Password',
                  controller: passwordController,
                  onChanged: (value) {
                    passwordController.text = value;
                  },
                ),
                UIHelper.verticalSpaceSmall,
                StatefulBuilder(builder: (context, setState) {
                  return Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildCheckbox(
                        text: 'Number',
                        value: number,
                        onChanged: (newValue) {
                          setState(() => {number = newValue});
                          print(number);
                        },
                      ),
                      buildCheckbox(
                        text: 'Letter',
                        value: letter,
                        onChanged: (newValue) {
                          setState(() => {letter = newValue});
                          print(letter);
                        },
                      ),
                      buildCheckbox(
                        text: 'Symbol',
                        value: symbol,
                        onChanged: (newValue) {
                          setState(() => {symbol = newValue});
                          print(symbol);
                        },
                      ),
                    ],
                  );
                }),
                StatefulBuilder(builder: (context, setState) {
                  return ElevatedButtonWidget(
                      text: 'Generate Random Password',
                      onPressedParam: () {
                        var temp = GeneratePassword.getRandomString(
                            letter: letter, number: number, symbol: symbol);
                        setState(() {
                          passwordController.text = temp;
                        });
                        print(temp);
                      });
                }),
                UIHelper.verticalSpaceSmall,
                ElevatedButtonWidget(
                    text: 'Save',
                    onPressedParam: () {
                      appModel.addItem(
                          appItem: AppItem(
                              name: name, password: passwordController.text));
                      Navigator.pop(context);
                    }),
                UIHelper.horizontalSpaceLarge,
                UIHelper.horizontalSpaceLarge,
              ],
            ),
          ),
        );
      },
    );
  }

  Expanded buildCheckbox(
      {required String text, required bool value, required dynamic onChanged}) {
    return Expanded(
      child: Row(
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
          ),
          Text(
            text,
            style: CustomStyle.subtitleStyle,
          )
        ],
      ),
    );
  }

  Card buildItemData({String? name, String? password, required onPressed}) {
    return Card(
      child: ListTile(
        title: Text(name!, style: CustomStyle.titleStyle),
        subtitle: Text(
          toObscureText(password!),
          style: CustomStyle.subtitleStyle,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ElevatedButton(
                child: Icon(Icons.remove_red_eye),
                onPressed: onPressed,
              ),
            ),
            SizedBox(
              width: UIHelper.edgeMedium,
            ),
            Flexible(
              child: ElevatedButton(
                child: Icon(Icons.edit),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  String toObscureText(String string) {
    String obscureText = '';
    for (var character in string.characters) {
      obscureText += '*';
    }
    return obscureText;
  }
}
