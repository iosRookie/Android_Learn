abstract class IRequestProxy {
  Map<String, dynamic> proxy(Map<String, dynamic> requests);
}

abstract class IResponseProxy {
  dynamic proxy(String url, String data, String clazz);
}

abstract class IErrorProxy {
  dynamic proxy(String url, e);
}
