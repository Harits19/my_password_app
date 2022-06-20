import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_password_app/konstan/k_size.dart';

class SnackBarWidget {
  static void show({required title, required message}) {
    Get.snackbar(title, message,
        margin: EdgeInsets.symmetric(
          vertical: KSize.edgeLarge,
          horizontal: KSize.edgeMedium,
        ));
  }
}
