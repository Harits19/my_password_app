class FileNotFoundException implements Exception {
  final String _message;

  FileNotFoundException(this._message);

  @override
  String toString() {
    return _message;
  }
}
