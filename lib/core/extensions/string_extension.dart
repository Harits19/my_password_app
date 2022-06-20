import 'package:characters/characters.dart';

class StringHelper {
  StringHelper._();
}

extension StringNullExtension on String? {
  String toObscureText() {
    if (this == null) return "";
    String obscureText = '';
    for (final _ in this!.characters) {
      obscureText += '*';
    }
    return obscureText;
  }
}
