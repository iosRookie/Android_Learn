import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/contact/contact_router.dart';
import 'package:flutter_app/Simbox/login/login_router.dart';
import 'package:flutter_app/Simbox/person/person_router.dart';
import 'package:flutter_app/Simbox/routes/page_not_found.dart';
import 'package:flutter_app/Simbox/routes/router_init.dart';

class Routes {
  static List<IRouterProvider> _moduleRoutes = [];

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return PageNotFount();
    });

//  添加各模块路由
    _moduleRoutes.add(LoginRouter());
    _moduleRoutes.add(ContactRouter());
    _moduleRoutes.add(PersonRouter());

    _moduleRoutes.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
