import 'package:fluro/fluro.dart';
import 'package:flutter_app/Simbox/contact/page/contact_home_page.dart';
import 'package:flutter_app/Simbox/contact/page/import_contact_page.dart';
import 'package:flutter_app/Simbox/routes/router_init.dart';

class ContactRouter implements IRouterProvider {
  static String contactPage = '/contactPage';
  static String importContacts = '/contactPage/importContacts';

  @override
  void initRouter(Router router) {
    router.define(contactPage, handler: Handler(handlerFunc: (_, params) => ContactHomePage()));
    router.define(importContacts, handler: Handler(handlerFunc: (_, params) => ImportContactsPage()));
  }
}