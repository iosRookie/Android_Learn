class NetException implements Exception {
  ErrorType errorType;
  String message;
  String code;
  dynamic e;

  NetException({this.errorType, this.message, this.e, this.code});

  @override
  String toString() {
    var msg = 'NetException [$errorType]: $code $message';
    if (e is Error) {
      msg += '\n${e.stackTrace}';
    }
    return msg;
  }
}

class RetryException {
  Exception e;
  final String retryKey;
  int maxRetryTimes;
  int delaySec;

  RetryException(this.retryKey, this.e, {this.maxRetryTimes, this.delaySec});
}

enum ErrorType { UNKNOWN, CONNECT_TIMEOUT, RECEIVE_TIMEOUT, SEND_TIMEOUT, CANCEL, SOCKET, RESPONSE }
