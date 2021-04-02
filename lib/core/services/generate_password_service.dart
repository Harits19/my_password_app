import 'dart:math';

class GeneratePassword {
  static const _number = '1234567890';
  static const _letter = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
  static const _symbol = '`~!@#%^&*()_-+[]}|;' ",./<>?";
  static var _chartDefault = '$_number$_letter$_symbol';

  static Random _rnd = Random();

  static String getRandomString(
      {int length = 9,
      bool number = true,
      bool letter = false,
      bool symbol = false}) {
    if (number || letter || symbol) {
      _chartDefault = '';
      if (number) _chartDefault += _number;
      if (letter) _chartDefault += _letter;
      if (symbol) _chartDefault += _symbol;
    } else {
      _chartDefault = '$_number$_letter$_symbol';
    }

    return String.fromCharCodes(Iterable.generate(length,
        (_) => _chartDefault.codeUnitAt(_rnd.nextInt(_chartDefault.length))));
  }
}
