import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_provider.dart';

abstract class BasePage extends _BasePage {
  @override
  PreferredSizeWidget setAppbar(BuildContext context) {
    return null;
  }

  @override
  Widget setBody(BuildContext context) {
    return null;
  }

  @override
  Widget setBottomNavigationBar(BuildContext context) {
    return null;
  }

  @override
  Widget setDrawer(BuildContext context) {
    return null;
  }
}

abstract class _BasePage extends StatelessWidget {
  final HashMap<String, BaseProvider> _providers = HashMap();
  final _globalKey = GlobalKey<ScaffoldState>();
  List<BaseProvider> setProviders();

  Widget doBuild(BuildContext context, Widget scaffold);

  PreferredSizeWidget setAppbar(BuildContext context);

  Widget setBody(BuildContext context);

  Widget setDrawer(BuildContext context);

  Widget setBottomNavigationBar(BuildContext context);

  @override
  Widget build(BuildContext context) {
    var presents = setProviders();
    if (presents != null) {
      presents.forEach((item) {
        var name = item.runtimeType.toString();
        if(!_providers.containsKey(name)){
          item.context = context;
          item.globalKey = _globalKey;
          item.init();
          _providers[name] = item;
        }
      });
    }

    var scaffold = SafeArea(
        child: Scaffold(
          key: _globalKey,
          appBar: setAppbar(context),
          body: setBody(context),
          bottomNavigationBar: setBottomNavigationBar(context),
          drawer: setDrawer(context),
        )
    );
    return doBuild(context, scaffold);
  }

  T getProvider<T>() {
    if (_providers.containsKey(T.toString())) {
      return _providers[T.toString()] as T;
    }
    return null;
  }
}
