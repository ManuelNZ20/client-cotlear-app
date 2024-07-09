class WrongCredentials implements Exception {
  // @override
  // String get message => throw UnimplementedError();

  // @override
  // String? get statusCode => throw UnimplementedError();
}

class InvalidToken implements Exception {}

class ConnectionTimeout implements Exception {}

class CustomError implements Exception {
  final String errorMessage;
  // final int errorCode;

  CustomError(this.errorMessage /* , this.errorCode */);
}
