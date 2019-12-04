import 'package:fluro/fluro.dart';
import 'package:flutter_app/Simbox/login/page/CountryCodeSelectPage.dart';
import 'package:flutter_app/Simbox/main/SimboxMianPage.dart';
import 'package:flutter_app/Simbox/routes/RouterInit.dart';

import 'page/LoginPage.dart';
import 'page/RegisterPage.dart';
import 'page/ResetPasswordPage.dart';
import 'page/SMSLoginPage.dart';
import 'page/UpdatePasswordPage.dart';

class LoginRouter implements IRouterProvider {
  static String loginPage = '/login';
  static String countryCodeSelectPage = '/login/countryCodeSelect';
  static String registerPage = '/login/register';
  static String smsLoginPage = '/login/smsLogin';
  static String resetPasswordPage = '/login/resetPassword';
  static String updatePasswordPage = '/login/updatePassword';

  static String mainHomePage = '/';

  @override
  void initRouter(Router router) {
    router.define(loginPage, handler: Handler(handlerFunc: (_, params) => LoginPage()));
    router.define(countryCodeSelectPage, handler: Handler(handlerFunc: (_, params) => CountryCodeSelectPage()));
    router.define(registerPage, handler: Handler(handlerFunc: (_, params) => RegisterPage()));
    router.define(smsLoginPage, handler: Handler(handlerFunc: (_, params) => SMSLoginPage()));
    router.define(resetPasswordPage, handler: Handler(handlerFunc: (_, params) => ResetPasswordPage()));
    router.define(updatePasswordPage, handler: Handler(handlerFunc: (_, params) => UpdatePasswordPage()));

    router.define(mainHomePage, handler: Handler(handlerFunc: (_, params) => SimboxMainPage()));
  }

}