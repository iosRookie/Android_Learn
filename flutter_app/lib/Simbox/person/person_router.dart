import 'package:fluro/fluro.dart';
import 'package:flutter_app/Simbox/login/page/login_page.dart';
import 'package:flutter_app/Simbox/routes/router_init.dart';

class PersonRouter extends IRouterProvider {
  static String loginPage = '/login';

  @override
  void initRouter(Router router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, params) => LoginPage()));
  }

}