class NetException implements Exception {
  ErrorType errorType;
  String message;
  String code;
  dynamic e;

  NetException({this.errorType, this.message, this.e, this.code});
}

class RetryException {
  Exception e;
  final String retryKey;
  int maxRetryTimes;
  int delaySec;

  RetryException(this.retryKey, this.e, {this.maxRetryTimes, this.delaySec});
}

enum ErrorType { UNKNOWN, TIMEOUT, HTTP, RESPONSE }
