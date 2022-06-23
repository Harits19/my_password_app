import 'package:characters/characters.dart';
import 'package:encrypt/encrypt.dart';
import 'package:my_password_app/env.dart';
import 'package:easy_localization/easy_localization.dart';

class StringExtensionHelper {
  StringExtensionHelper._();
}

extension StringNullExtension on String? {

  bool get isNullEmpty{
    return this?.isEmpty ?? true;
  }

  String toObscureText() {
    if (this == null) return "";
    String obscureText = '';
    for (final _ in this!.characters) {
      obscureText += '*';
    }
    return obscureText;
  }

  String get encrypt {
    if (this.isNullEmpty) {
      throw "emptyString".tr();
    }

    final encrypted = _encrypter.encrypt(this!, iv: _iv);

    return encrypted.base64;
  }

  String get decrypt {
    if (this.isNullEmpty) {
      throw "emptyString".tr();
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
