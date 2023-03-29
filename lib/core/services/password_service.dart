import 'dart:convert';
import 'dart:developer';

import 'package:my_password_app/core/extensions/shared_pref_extension.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/core/services/services.dart';
import 'package:my_password_app/utils/encrypt_data.dart';
import 'package:my_password_app/core/enums/pref_enum.dart';

class PasswordService {
  static Future<void> save(List<PasswordModel> passwords) {
    final listMap = jsonEncode(passwords.map((e) => e.toJson()).toList());
    final encoded = EncryptData.encode(listMap);
    print(encoded);
    return Services.prefs.setStringV2(PrefEnum.listPassword, encoded);
  }

  static List<PasswordModel> get() {
    final result = Services.prefs.getStringV2(PrefEnum.listPassword);
    if (result.isNullEmpty) return [];
    final decoded = EncryptData.decode(result!);
    print(decoded);
    final decodeJson = jsonDecode(decoded);
    if (decodeJson is List) {
      return decodeJson.map((e) => PasswordModel.fromJson(e)).toList();
    }
    return [];
  }
}
