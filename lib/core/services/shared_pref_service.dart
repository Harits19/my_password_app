import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_password_app/core/extensions/shared_pref_extension.dart';
import 'package:my_password_app/core/extensions/string_extension.dart';
import 'package:my_password_app/core/models/password_model.dart';
import 'package:my_password_app/core/services/encrypt_data.dart';
import 'package:my_password_app/core/enums/pref_enum.dart';
import 'package:my_password_app/core/utils/my_print.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPrefService = Provider<SharedPrefService>((ref) {
  return SharedPrefService(
    encryptDataService: ref.watch(encryptDataService),
  );
});

class SharedPrefService {
  SharedPreferences? prefs;

  SharedPrefService({
    required EncryptDataService encryptDataService,
  }) : _encryptDataService = encryptDataService;

  final EncryptDataService _encryptDataService;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<void> save(List<PasswordModel> passwords) {
    final listMap = jsonEncode(passwords.map((e) => e.toJson()).toList());
    final encoded = _encryptDataService.encode(listMap);
    myPrint(encoded);
    return prefs.setStringV2(PrefEnum.listPassword, encoded);
  }

  List<PasswordModel> getListPassword() {
    final result = prefs.getStringV2(PrefEnum.listPassword);
    if (result.isNullEmpty) return [];
    final decoded = _encryptDataService.decode(result!);
    myPrint('getPasswordCache : ' + decoded);
    final decodeJson = jsonDecode(decoded);
    if (decodeJson is List) {
      return decodeJson.map((e) => PasswordModel.fromJson(e)).toList();
    }
    return [];
  }
}
