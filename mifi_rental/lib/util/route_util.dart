
class RouteUtil {
  static Future<Map<dynamic, dynamic>> openFlutter(
    String path, {
    Map<dynamic, dynamic> urlParams,
    bool clearTask,
  }) {
    return _route("flutter://$path",
        urlParams: urlParams, clearTask: clearTask);
  }

  static Future<Map<dynamic, dynamic>> openNative(
    String path, {
    Map<dynamic, dynamic> urlParams,
    bool clearTask,
  }) {
    return _route("native://$path", urlParams: urlParams, clearTask: clearTask);
  }

  static Future<Map<dynamic, dynamic>> _route(
    String url, {
    Map<dynamic, dynamic> urlParams,
    bool clearTask,
  }) {
    var exts = Map<dynamic, dynamic>();
    exts['animated'] = true;
    if (clearTask != null) {
      exts["clearTask"] = clearTask;
    }
//    return FlutterBoost.singleton.open(url, urlParams: urlParams, exts: exts);
  }
}
