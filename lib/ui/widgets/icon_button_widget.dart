import 'package:flutter/material.dart';
import 'package:my_password_app/core/extensions/context_extension.dart';

class IconButtonWidget extends InkWell {
  IconButtonWidget({super.onTap, super.child});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(context.mSize.width),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: super.child,
        ),
        onTap: super.onTap,
      ),
    );
  }
}
