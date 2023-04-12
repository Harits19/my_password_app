import 'package:flutter/material.dart';
import 'package:my_password_app/ui/konstans/k_size.dart';

class PasswordFooterView extends StatelessWidget {
  const PasswordFooterView({super.key, this.children = const []});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KSize.s8),
      child: Row(
        children: children,
      ),
    );
  }
}