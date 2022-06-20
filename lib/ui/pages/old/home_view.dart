import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/app.dart';
import 'package:my_password_app/core/services/generate_password_service.dart';
import 'package:my_password_app/core/viewmodels/app_models.dart';
import 'package:my_password_app/core/viewmodels/auth_model.dart';
import 'package:my_password_app/konstan/k_style.dart';
import 'package:my_password_app/konstan/k_size.dart';
import 'package:my_password_app/ui/helper/show.dart';
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
          Show.modalPassword(
              context: context,
              passwordController: passwordController,
              nameController: nameController,
              onPressedSave: () {
                if (nameController.text.isEmpty ||
                    passwordController.text.isEmpty) {
                  Show.snackbar(context, 'Data tidak lengkap');
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
                            ? password.toObscureText()
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
                                        Show.modalPassword(
                                            context: context,
                                            passwordController:
                                                passwordController,
                                            nameController: nameController,
                                            onPressedSave: () {
                                              if (nameController.text.isEmpty ||
                                                  passwordController
                                                      .text.isEmpty) {
                                                Show.snackbar(context,
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
                                      (value) => Show.snackbar(
                                          context, 'Berhasil disalin'));
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
}
