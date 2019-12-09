import 'package:fluro/fluro.dart';
import 'package:flutter_app/Simbox/login/page/country_code_select_page.dart';
import 'package:flutter_app/Simbox/main/Simbox_mian_page.dart';
import 'package:flutter_app/Simbox/routes/router_init.dart';

import 'page/login_page.dart';
import 'page/register_page.dart';
import 'page/reset_password_page.dart';
import 'page/sms_login_page.dart';
import 'page/update_password_page.dart';

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