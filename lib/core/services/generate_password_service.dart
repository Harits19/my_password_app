import 'dart:math';

class GeneratePassword {
  static const _number = '1234567890';
  static const _letter = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  static const _symbol = '`~!@#%^&*()_-+[]}|;' ",./<>?";
  static var _chartDefault = '$_number$_letter$_symbol';

  static Random _rnd = Random();

  static String getRandomString({
    int length = 9,
    bool number = true,
    bool letter = false,
    bool symbol = false,
  }) {
    if (number || letter || symbol) {
      _chartDefault = '';
      if (number) _chartDefault += _number;
      if (letter) _chartDefault += _letter;
      if (symbol) _chartDefault += _symbol;
    } else {
      _chartDefault = '$_number$_letter$_symbol';
    }

    final first = _randomString(1, _letter);
    final second = _randomString(1, _letter);
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
