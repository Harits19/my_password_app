
class KExtension {
  KExtension._();
}

extension StringExtension on String? {
  bool get isNullEmpty {
    return this?.isEmpty ?? true;
  }
}
