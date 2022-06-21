class IdNotFoundException implements Exception {
  final String _message;

  IdNotFoundException(this._message);

  @override
  String toString() {
    return _message;
  }
}
