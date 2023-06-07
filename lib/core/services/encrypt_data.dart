import 'package:encrypt/encrypt.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final encryptDataService = Provider<EncryptDataService>((ref) {
  return EncryptDataService();
});

class EncryptDataService {
  final iv = IV.fromLength(16);

  String encode(String plainText) {
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return encrypted.base64;
  }

  String decode(String plainText) {
    final encrypted = Encrypted.fromBase64(plainText);
    return encrypter.decrypt(encrypted, iv: iv);
  }

  Encrypter get encrypter {
    final key = Key.fromUtf8(':>u]<TdX9F]G.3Ug(CR.t/Vk+BV~%>Lw');
    return Encrypter(AES(key));
  }
}
