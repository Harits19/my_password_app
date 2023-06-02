import 'package:flutter/material.dart';
import 'package:my_password_app/ui/pages/home/views/password_footer_view.dart';

class DeleteFooterView extends StatelessWidget {
  const DeleteFooterView({super.key, this.onPressNo, this.onPressYes});

  final VoidCallback? onPressYes, onPressNo;

  @override
  Widget build(BuildContext context) {
    return PasswordFooterView(
      children: [],
    );
  }
}
