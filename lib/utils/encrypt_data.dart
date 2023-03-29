import 'package:encrypt/encrypt.dart';

class EncryptData {
  static final iv = IV.fromLength(16);

  static String encode(String plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  static String decode(String plainText) {
    final encrypted = Encrypted.fromBase64(plainText);
    return encrypter.decrypt(encrypted, iv: iv);
  }

  static Encrypter get encrypter {
    final key = Key.fromUtf8(':>u]<TdX9F]G.3Ug(CR.t/Vk+BV~%>Lw');
    return Encrypter(AES(key));
  }
}
