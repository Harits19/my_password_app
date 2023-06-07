import 'dart:math';

import 'package:my_password_app/enums/generate_enum.dart';

class GeneratePassword {
  static Random _rnd = Random();

  static String getRandomString({
    int length = 9,
    required Map<GenerateEnum, bool> passwordConfig,
  }) {
    var _chartDefault = '';
    var checkVal = false;
    for (final item in passwordConfig.entries) {
      if (item.value) {
        _chartDefault += item.key.char;
        checkVal = true;
      }
    }
    if (!checkVal) throw 'Choose minimum one type character';

    final first = _randomString(1, GenerateEnum.letter.char);
    final second = _randomString(1, GenerateEnum.letter.char);
    final lastLength = length - 2;
    if (lastLength <= 1) {
      assert(lastLength <= 1);
    }
    return first + _randomString(lastLength, _chartDefault) + second;
  }

  static String _randomString(int length, String combination) {
    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => combination.codeUnitAt(
          _rnd.nextInt(
            combination.length,
          ),
        ),
      ),
    );
  }
}
