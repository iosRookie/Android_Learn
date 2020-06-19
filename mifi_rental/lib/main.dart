import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:core_log/core_log.dart';
import 'package:core_net/adapter/dio/dio_adapter.dart';
import 'package:core_net/net_configurator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_boost/container/boost_page_route.dart';
//import 'package:flutter_boost/flutter_boost.dart';
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
import 'package:mifi_rental/page/rent/rent_provider.dart';
import 'package:mifi_rental/page/rent_fail/rent_fail_page.dart';
import 'package:mifi_rental/page/success/success_page.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';
import 'package:provider/provider.dart';

import 'common/route.dart';
import 'db/db_order.dart';
import 'db/db_user.dart';
import 'entity/order.dart';
import 'entity/user.dart';
import 'localizations/localizations.dart';
import 'localizations/localizations_delegate.dart';
import 'net/net_proxy.dart';
import 'package:native_system_default_config/native_system_default_config.dart';

//buythree@163.com
//密码都是: 123456789

// keep it  协议的位置：  /MiFiRent/DHIRental/flow_explain_en_DHI.html  /MiFiRent/DHIRental/flow_explain_zh-cn_DHI.html      和租赁协议一样， 每个MVNO或许会不同，根据面包机的MVNO来取
// keep it  协议的位置：  /MiFiRent/DHIRental/keepit_agreement_en_DHI.json  /MiFiRent/DHIRental/keepit_agreement_zh-cn_DHI.json    和租赁协议一样， 每个MVNO或许会不同，根据面包机的MVNO来取


void main() async {
  runApp(
      MaterialApp(
          title: 'mifi_rental',
          theme: ThemeData(
              primarySwatch: Colors.blue, primaryColor: color_bg_main,primaryColorBrightness:Brightness.light),
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
//            builder: FlutterBoost.init(postPush: _onRoutePushed),
          home: Container(
              color: Colors.white,
              child: MyApp()
          )
      )
  );

  await initAppData();
}

Future<void> initAppData() async {
  if (Platform.isIOS) {
    SharedPreferenceUtil.saveNativeLocal(
        await NativeSystemDefaultConfig.nativeDefaultLanguage);
  }

//  await RentProvider().checkOrder();
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Timer queryTimer;
  DeviceNotifyProvider deviceNotifyProvider = DeviceNotifyProvider();

  int existUsingDevice = 0; // 0:默认值 1:无正在使用的设备 2:有正在使用的设备

  @override
  void initState() {
    super.initState();
//    FlutterBoost.singleton.registerPageBuilders({
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
//      RENT: (pageName, params, _) => RentPage(),
//      DEVICE: (pageName, params, _) => DevicePage(),
//      FAULR_REPORT: (pageName, params, _) => FaultReporting(),
//      PAY: (pageName, params, _) {
//        return PayPage(params['sn']);
//      },
//      PROBLEM: (pageName, params, _) => ProblemPage(),
//      RENT_FAIL: (pageName, params, _) => RentFailPage(),
//      FLOW_PACKAGE: (pageName, params, _) => FlowPackagePage(),
//      SUCCESS: (pageName, params, _) => SuccessPage(),
//      QUERY: (pageName, params, _) => QueryPage(),
//      PAY_FAIL: (pageName, params, _) => PayFailPage(params['sn']),
//    });

//    FlutterBoost.singleton
//        .addBoostNavigatorObserver(TestBoostNavigatorObserver());
//
//    FlutterBoost.singleton.addBoostContainerLifeCycleObserver(
//        (ContainerLifeCycle state, BoostContainerSettings settings) {
//      ULog.d('lifeCycleObserver#page:${settings.name} state:$state ');
//      switch (state) {
//        case ContainerLifeCycle.Background:
//          break;
//        case ContainerLifeCycle.Init:
//          break;
//        case ContainerLifeCycle.Appear:
//          switch (settings.name) {
//            case 'device':
//              _cancelQuery();
//              deviceNotifyProvider.refresh();
//              queryTimer = Timer.periodic(Duration(minutes: 3), (timer) {
//                deviceNotifyProvider.refresh();
//              });
//              break;
//          }
//          break;
//        case ContainerLifeCycle.WillDisappear:
//          break;
//        case ContainerLifeCycle.Disappear:
//          if (settings.name == 'device') {
//            _cancelQuery();
//          }
//          break;
//        case ContainerLifeCycle.Destroy:
//          break;
//        case ContainerLifeCycle.Foreground:
//          break;
//      }
//    });

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

    queryUseOrder();
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
          ChangeNotifierProvider(create: (_) => deviceNotifyProvider),
        ],
        child: currentDisplayPage()
    );
  }

  Widget currentDisplayPage() {
    Widget usedWidget = Container(
      color: Colors.white,
    );
    switch (existUsingDevice) {
      case 1:
        usedWidget = RentPage();
        break;
      case 2:
        usedWidget = DevicePage();
        break;
      default:
        break;
    }
    return usedWidget;
  }

  void _onRoutePushed(String pageName, String uniqueId, Map params, Route route, Future _) {}

  Future<void> queryUseOrder() async {
    var order = await OrderDb().query();
    if (order != null) {
      var user = await UserDb().query();
      ULog.d('查询正在使用订单');
      await OrderRepository.queryOrderInfo(
        orderSn: order.orderSn,
        loginCustomerId: user.loginCustomerId,
        langType: MyLocalizations.of(context).getLanguage(),
        success: ((o) {
          if (o.orderStatus == OrderStatus.IN_USING) {
            setState(() {
              existUsingDevice = 2; // 设备界面
            });
          } else {
            setState(() {
              existUsingDevice = 1; // 租赁界面
            });
          }
        }),
        error: ((e) {
          setState(() {
            existUsingDevice = 1;  // 租赁界面
          });
          ULog.d('main订单查询请求失败' + e.toString());
        }),
      );
    } else {
      setState(() {
        existUsingDevice = 1; // 租赁界面
      });
    }
  }

}

class TestBoostNavigatorObserver extends NavigatorObserver {
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _logRoute("didPush", route, previousRoute);
  }

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    _logRoute("didPop", route, previousRoute);
  }

  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    _logRoute("didRemove", route, previousRoute);
  }

  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    _logRoute("didReplace", newRoute, oldRoute);
  }

  _logRoute(String method, Route<dynamic> route, Route<dynamic> previousRoute) {
    String pageName;
//    if (route is BoostPageRoute) {
//      pageName = route.pageName;
//    }
    pageName != null
        ? ULog.i("flutterboost#$method pageName:$pageName")
        : ULog.i("flutterboost#$method");
  }
}
