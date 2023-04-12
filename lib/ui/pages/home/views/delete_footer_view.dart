import 'package:flutter/material.dart';
import 'package:my_password_app/ui/pages/home/views/password_footer_view.dart';
import 'package:my_password_app/ui/widgets/space_widget.dart';



class DeleteFooterView extends StatelessWidget {
  const DeleteFooterView({super.key, this.onPressNo, this.onPressYes});

  final VoidCallback? onPressYes, onPressNo;

  @override
  Widget build(BuildContext context) {
    return PasswordFooterView(
      children: [
        Expanded(
          child: ElevatedButton(
            child: Text('Yes'),
            onPressed: onPressYes,
          ),
        ),
        SpaceWidget.hori8,
        Expanded(
          child: ElevatedButton(
            child: Text('No'),
            onPressed: onPressNo,
          ),
        ),
      ],
    );
  }
}