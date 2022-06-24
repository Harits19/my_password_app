import 'package:characters/characters.dart';
extension StringNullExtension on String? {

  bool get isNullEmpty{
    return this?.isEmpty ?? true;
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
