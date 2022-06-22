import 'package:characters/characters.dart';
import 'package:encrypt/encrypt.dart';
import 'package:my_password_app/env.dart';

class StringExtensionHelper {
  StringExtensionHelper._();
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

  String get encrypt {
    if (this == null) {
      throw "Empty String";
    }

    final encrypted = _encrypter.encrypt(this!, iv: _iv);

    return encrypted.base64;
  }

  String get decrypt {
    if (this == null) {
      throw "Empty String";
    }

    final decrypted = _encrypter.decrypt64(this!, iv: _iv);

    return decrypted;
  }

  Encrypter get _encrypter {
    final key = Key.fromBase64(Env.encryptKey);
    return Encrypter(AES(key));
  }

  IV get _iv {
    return IV.fromLength(16);
  }
}
