import 'package:flutter/material.dart';

class TextFieldPasswordWidget extends StatefulWidget {
  const TextFieldPasswordWidget({
    super.key,
    this.onChanged,
    this.decoration = const InputDecoration(),
  });

  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;

  @override
  State<TextFieldPasswordWidget> createState() =>
      _TextFieldPasswordWidgetState();
}

class _TextFieldPasswordWidgetState extends State<TextFieldPasswordWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: widget.decoration?.copyWith(
        suffix: InkWell(
          onTap: () {
            obscureText = !obscureText;
            setState(() {});
          },
          child: Text(
            obscureText ? 'SHOW' : 'HIDE',
          ),
        ),
      ),
      onChanged: widget.onChanged,
    );
  }
}
