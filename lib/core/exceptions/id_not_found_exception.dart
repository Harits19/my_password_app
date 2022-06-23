class IdNotFoundException implements Exception {

  IdNotFoundException();

  @override
  String toString() {
    return "Id Not Found";
  }
}
