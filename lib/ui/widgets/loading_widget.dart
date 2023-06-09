import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_password_app/ui/widgets/widget_util.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  static dialog(BuildContext context) {
    debugPrint('showLoading');
    WidgetUtil.checkWidget(() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: LoadingWidget(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}
