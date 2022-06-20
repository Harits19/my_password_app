import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_password_app/core/models/app.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/core/viewmodels/auth_model.dart';
import 'package:my_password_app/konstan/k_style.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:my_password_app/ui/widgets/custom_widget.dart';

class HomeView extends StatelessWidget {
  final AppModel appModel = Get.put(AppModel());
  final AuthModel authModel = Get.find();

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    appModel.getApp();
    // print(authModel.data.value.pin);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(KSize.edgeMedium),
          child: Column(
            children: <Widget>[
              // TextFieldWidget(
              //   hintText: 'Cari Aplikasi',
              //   onChanged: (newValue) {
              //     setState(() => {searchList = searchResult(newValue)});
              //   },
              // ),
              Expanded(
                child: Obx(
                  () => appModel.items.isEmpty
                      ? Center(
                          child: Text(
                            'Data tidak ditemukan',
                            style: KStyle.h1,
                          ),
                        )
                      : ListView.builder(
                          itemCount: appModel.items.length,
                          // searchList.isNotEmpty
                          //     ? searchList.length
                          //     : appModel.items.length,
                          itemBuilder: (context, index) {
                            // var data = searchList.isNotEmpty
                            //     ? searchList
                            //     : appModel.items;
                            // var isSearch =
                            //     searchList.isNotEmpty ? true : false;
                            var data = appModel.items;
                            return buildItemData(
                                name: data[index].name,
                                password: data[index].password,
                                index: index,
                                nameController: nameController,
                                passwordController: passwordController);
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          buildShowModalBottomSheet(
              context: context,
              passwordController: passwordController,
              nameController: nameController,
              onPressedSave: () {
                if (nameController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  SnackBarWidget.show(
                      title: 'Gagal', message: 'Data tidak lengkap');
                } else {
                  appModel.addAppItem(
                      appItem: App(
                          name: nameController.text,
                          password: passwordController.text));
                  Get.back();
                }
              });
          passwordController.text = '';
          nameController.text = '';
        },
      ),
    );
  }

  dynamic searchResult(String inputString) {
    if (appModel.items.any((element) =>
        element.name.toLowerCase().contains(inputString.toLowerCase()))) {
      return appModel.items
          .where((element) =>
              element.name.toLowerCase().contains(inputString.toLowerCase()))
          .toList();
      // searchFound = true;
    } else {
      return [];
      // searchFound = false;
    }
  }

  // void setCheckbox({required value, required newValue}) {
  //   value = newValue;
  // }

  Future<void> buildShowModalBottomSheet(
      {required BuildContext context,
      passwordController,
      nameController,
      required onPressedSave}) {
    bool number = false;
    bool letter = false;
    bool symbol = false;
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: KSize.edgeMedium, vertical: KSize.edgeLarge * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextFieldWidget(
                  hintText: 'Nama Aplikasi',
                  controller: nameController,
                ),
                TextFieldWidget(
                  hintText: 'Password',
                  controller: passwordController,
                ),
                KSize.verticalSmall,
                StatefulBuilder(builder: (context, setState) {
                  return Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: CheckboxWidget(
                          text: 'Number',
                          value: number,
                          onChanged: (newValue) {
                            setState(() => {number = newValue});
                            print(number);
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxWidget(
                          text: 'Letter',
                          value: letter,
                          onChanged: (newValue) {
                            setState(() => {letter = newValue});
                            print(letter);
                          },
                        ),
                      ),
                      Expanded(
                        child: CheckboxWidget(
                          text: 'Symbol',
                          value: symbol,
                          onChanged: (newValue) {
                            setState(() => {symbol = newValue});
                            print(symbol);
                          },
                        ),
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
                KSize.verticalSmall,
                ElevatedButtonWidget(
                    text: 'Simpan', onPressedParam: onPressedSave),
                KSize.horizontalLarge,
                KSize.horizontalLarge,
              ],
            ),
          ),
        );
      },
    );
  }

  StatefulBuilder buildItemData(
      {required String name,
      required String password,
      required index,
      required TextEditingController passwordController,
      required TextEditingController nameController,
      bool isSearch = false}) {
    bool isObscure = true;
    bool isDelete = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Card(
          color: isDelete ? Colors.red : Get.theme.cardTheme.color,
          child: InkWell(
            child: Column(
              children: [
                ListTile(
                  title: Text(isDelete ? 'Hapus data' : name, style: KStyle.h1),
                  subtitle: Text(
                    isDelete
                        ? 'Apakah kamu yakin?'
                        : isObscure
                            ? toObscureText(password)
                            : password,
                    style: KStyle.h2,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: KSize.edgeMedium),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: isDelete
                        ? [
                            Expanded(
                              child: ElevatedButton(
                                child: Text('Ya'),
                                onPressed: () {
                                  appModel.removeApp(index: index);
                                },
                              ),
                            ),
                            KSize.horizontalSmall,
                            Expanded(
                              child: ElevatedButton(
                                child: Text('Tidak'),
                                onPressed: () {
                                  setState(() => {isDelete = false});
                                },
                              ),
                            ),
                          ]
                        : [
                            Expanded(
                              child: ElevatedButton(
                                child: Icon(isObscure
                                    ? Icons.remove_red_eye_outlined
                                    : Icons.remove_red_eye),
                                onPressed: () {
                                  setState(() => {isObscure = !isObscure});
                                },
                              ),
                            ),
                            KSize.horizontalSmall,
                            isSearch
                                ? Container()
                                : Expanded(
                                    child: ElevatedButton(
                                      child: Icon(Icons.edit),
                                      onPressed: () {
                                        nameController.text = name;
                                        passwordController.text = password;
                                        buildShowModalBottomSheet(
                                            context: context,
                                            passwordController:
                                                passwordController,
                                            nameController: nameController,
                                            onPressedSave: () {
                                              if (nameController.text.isEmpty ||
                                                  passwordController
                                                      .text.isEmpty) {
                                                SnackBarWidget.show(
                                                    title: 'Gagal',
                                                    message:
                                                        'Data tidak lengkap');
                                              } else {
                                                appModel.updateAppItem(
                                                    appItem: App(
                                                        name:
                                                            nameController.text,
                                                        password:
                                                            passwordController
                                                                .text),
                                                    index: index);
                                                Get.back();
                                              }
                                            });
                                      },
                                    ),
                                  ),
                            KSize.horizontalSmall,
                            Expanded(
                              child: ElevatedButton(
                                child: Icon(Icons.copy),
                                onPressed: () {
                                  FlutterClipboard.copy(password).then(
                                      (value) => SnackBarWidget.show(
                                          title: 'Salin',
                                          message: 'Berhasil disalin'));
                                },
                              ),
                            ),
                          ],
                  ),
                ),
              ],
            ),
            onLongPress: () {
              setState(() => {isDelete = true});
            },
          ),
        );
      },
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
