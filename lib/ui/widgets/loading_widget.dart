import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = Get.size.width * 0.25;
    return SizedBox(
        width: 40.0, height: 40.0, child: CircularProgressIndicator());
  }
}
