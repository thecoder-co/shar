class StringException implements Exception {
  String exception;
  StringException(this.exception);
  @override
  String toString() {
    // TODO: implement toString
    return exception;
  }
}
