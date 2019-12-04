import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/login/LoginRouter.dart';
import 'package:flutter_app/Simbox/routes/PageNotFound.dart';
import 'package:flutter_app/Simbox/routes/RouterInit.dart';

class Routes {
  static List<IRouterProvider> _moduleRoutes = [];

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return PageNotFount();
    });

//  添加各模块路由
    _moduleRoutes.add(LoginRouter());

    _moduleRoutes.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
