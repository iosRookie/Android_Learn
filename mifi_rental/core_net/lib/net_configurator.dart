import 'dart:collection';
import 'package:core_net/core_net.dart';
import 'package:core_net/net_proxy.dart';
class NetConfigurator {
  static NetConfigurator get singleton => _getInstance();

  static NetConfigurator _getInstance() {
    if (_instance == null) {
      _instance = new NetConfigurator._internal();
    }
    return _instance;
  }

  static NetConfigurator _instance;

  NetConfigurator._internal();

  final HashMap<Config, dynamic> _configs = HashMap();

  NetConfigurator setAdapter(INetAdapter adapter) {
    _configs[Config.ADAPTER] = adapter;
    return this;
  }

  NetConfigurator setRequestProxy(IRequestProxy proxy) {
    _configs[Config.REQUEST_PROXY] = proxy;
    return this;
  }

  NetConfigurator setResponseProxy(IResponseProxy proxy) {
    _configs[Config.RESPONSE_PROXY] = proxy;
    return this;
  }

  NetConfigurator setErrorProxy(IErrorProxy proxy) {
    _configs[Config.ERROR_PROXY] = proxy;
    return this;
  }

  configure() {
    if (_configs[Config.ADAPTER] != null) {
      _configs[Config.CONFIG_READY] = true;
    } else {
      throw Exception("NetConfiguration has not adapter,call setAdapter");
    }
  }

  T getConfiguration<T>(Config config) {
    var isReady = _configs[Config.CONFIG_READY] ?? false;
    if (isReady) {
      return _configs[config];
    } else {
      throw Exception("NetConfiguration is not ready,call configure");
    }
  }
}

enum Config {
  ADAPTER,
  REQUEST_PROXY,
  RESPONSE_PROXY,
  ERROR_PROXY,
  CONFIG_READY
}