import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:core_log/core_log.dart';
import 'package:core_net/adapter/dio/dio_adapter.dart';
import 'package:core_net/net_configurator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mifi_rental/page/device/device_page.dart';
import 'package:mifi_rental/page/device/notify_provider.dart';
import 'package:mifi_rental/page/fault_notification.dart';
import 'package:mifi_rental/page/flow_package_page.dart';
import 'package:mifi_rental/page/pay/pay_page.dart';
import 'package:mifi_rental/page/pay_fail/pay_fail_page.dart';
import 'package:mifi_rental/page/problem/problem_page.dart';
import 'package:mifi_rental/page/query/query_page.dart';
import 'package:mifi_rental/page/rent/rent_page.dart';
import 'package:mifi_rental/page/rent_fail/rent_fail_page.dart';
import 'package:mifi_rental/page/success/success_page.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:provider/provider.dart';

import 'common/route.dart';
import 'db/db_user.dart';
import 'entity/user.dart';
import 'localizations/localizations_delegate.dart';
import 'net/net_proxy.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer queryTimer;
  NotifyProvider notifyProvider = NotifyProvider();

  @override
  void initState() {
    super.initState();
    FlutterBoost.singleton.registerPageBuilders({
//      'embeded': (pageName, params, _) => EmbededFirstRouteWidget(),
//      'first': (pageName, params, _) => FirstRouteWidget(),
//      'second': (pageName, params, _) => SecondRouteWidget(),
//      'tab': (pageName, params, _) => TabRouteWidget(),
//      'platformView': (pageName, params, _) => PlatformRouteWidget(),
//      'flutterFragment': (pageName, params, _) => FragmentRouteWidget(params),
//
//      ///可以在native层通过 getContainerParams 来传递参数
//      'flutterPage': (pageName, params, _) {
//        print("flutterPage params:$params");
//
//        return FlutterRouteWidget();
//      },
      RENT: (pageName, params, _) => RentPage(),
      DEVICE: (pageName, params, _) => DevicePage(),
      FAULR_REPORT: (pageName, params, _) => FaultReporting(),
      PAY: (pageName, params, _) {
        return PayPage(params['sn']);
      },
      PROBLEM: (pageName, params, _) => ProblemPage(),
      RENT_FAIL: (pageName, params, _) => RentFailPage(),
      FLOW_PACKAGE: (pageName, params, _) => FlowPackagePage(),
      SUCCESS: (pageName, params, _) => SuccessPage(),
      QUERY: (pageName, params, _) => QueryPage(),
      PAY_FAIL: (pageName, params, _) => PayFailPage(),
    });

    FlutterBoost.singleton.addBoostContainerLifeCycleObserver(
        (ContainerLifeCycle state, BoostContainerSettings settings) {
      ULog.d('lifeCycleObserver#page:${settings.name} state:$state ');
      switch (state) {
        case ContainerLifeCycle.Background:
          break;
        case ContainerLifeCycle.Init:
          break;
        case ContainerLifeCycle.Appear:
          if (settings.name == 'device') {
            _cancelQuery();
            notifyProvider.refresh();
            queryTimer = Timer.periodic(Duration(minutes: 3), (timer) {
              notifyProvider.refresh();
            });
          }
          break;
        case ContainerLifeCycle.WillDisappear:
          break;
        case ContainerLifeCycle.Disappear:
          if (settings.name == 'device') {
            _cancelQuery();
          }
          break;
        case ContainerLifeCycle.Destroy:
          break;
        case ContainerLifeCycle.Foreground:
          break;
      }
    });

    BaseOptions options = BaseOptions(
      baseUrl: "http://127.0.0.1/",
      responseType: ResponseType.plain,
      receiveDataWhenStatusError: true,
      connectTimeout: 15000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);

    NetConfigurator.singleton
        .setAdapter(DioAdapter(dio))
        .setRequestProxy(RequestProxy())
        .setResponseProxy(ResponseProxy())
        .setErrorProxy(ErrorProxy())
        .configure();
    _checkUser();
  }

  void _cancelQuery() {
    if (queryTimer != null && queryTimer.isActive) {
      queryTimer.cancel();
      queryTimer = null;
    }
  }

  void _checkUser() async {
    var d = UserDb();
    var user = await d.query();
    if (user == null) {
      var id = _createUserId();
      var user = new User(loginCustomerId: id);
      d.insert(user);
      ULog.d('loginCustomerId:${user.loginCustomerId}');
    } else {
      ULog.d('loginCustomerId:${user.loginCustomerId}');
    }
  }

  String _createUserId() {
    String alphabet = '0123456789qwertyuiopasdfghjklzxcvbnm';
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < 30; i++) {
      buffer.write(alphabet[Random().nextInt(alphabet.length)]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
//    return MaterialApp(
//        title: 'Flutter Boost example',
//        theme:
//            ThemeData(primarySwatch: Colors.blue, primaryColor: color_bg_main),
//        localizationsDelegates: [
//          // ... app-specific localization delegate[s] here
//          MyLocalizationsDelegate(),
//          GlobalMaterialLocalizations.delegate,
//          GlobalWidgetsLocalizations.delegate,
//        ],
//        supportedLocales: [
//          const Locale('en'),
//          const Locale('zh', 'CN'),
//          const Locale('zh', 'HK'),
//          const Locale('zh', 'TW'),
//        ],
//        builder: FlutterBoost.init(postPush: _onRoutePushed),
//        home: Container(color: Colors.white));

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => notifyProvider),
        ],
        child: MaterialApp(
            title: 'Flutter Boost example',
            theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: color_bg_main,
                appBarTheme: AppBarTheme(brightness: Brightness.light),
            ),
            localizationsDelegates: [
              // ... app-specific localization delegate[s] here
              MyLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('zh', 'CN'),
              const Locale('zh', 'HK'),
              const Locale('zh', 'TW'),
            ],
            builder: FlutterBoost.init(postPush: _onRoutePushed),
            home: Container(color: Colors.white)));
  }

  void _onRoutePushed(
      String pageName, String uniqueId, Map params, Route route, Future _) {}
}
