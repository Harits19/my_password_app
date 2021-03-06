import 'package:characters/characters.dart';

class StringExtensionHelper {}

extension StringNullExtension on String? {
  bool get isNullEmpty {
    return (this ?? "").trim().isEmpty;
  }

  String get toObscureText {
    if (this == null) return "";
    String obscureText = '';
    for (final _ in this!.characters) {
      obscureText += '*';
    }
    return obscureText;
  }
}
