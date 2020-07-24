import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:core_net/net_configurator.dart';
import 'package:core_net/net_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mifi_rental/common/loading_page_util.dart';
import 'package:mifi_rental/common/net_exception_page.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/page/device/device_page.dart';
import 'package:mifi_rental/page/fault_notification.dart';
import 'package:mifi_rental/page/flow_package/flow_package_page.dart';
import 'package:mifi_rental/page/flow_package/flow_package_pay_page.dart';
import 'package:mifi_rental/page/pay/pay_page.dart';
import 'package:mifi_rental/page/pay_fail/pay_fail_page.dart';
import 'package:mifi_rental/page/problem/problem_page.dart';
import 'package:mifi_rental/page/query/query_page.dart';
import 'package:mifi_rental/page/rent/rent_page.dart';
import 'package:mifi_rental/page/rent_fail/rent_fail_page.dart';
import 'package:mifi_rental/page/success/success_page.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';

import 'common/route.dart';
import 'entity/order.dart';
import 'localizations/localizations_delegate.dart';
import 'net/mr_dio_adapter.dart';
import 'net/net_proxy.dart';
import 'package:native_system_default_config/native_system_default_config.dart';

//buythree@163.com
//密码都是: 123456789

// keep it  协议的位置：  /MiFiRent/DHIRental/flow_explain_en_DHI.html  /MiFiRent/DHIRental/flow_explain_zh-cn_DHI.html      和租赁协议一样， 每个MVNO或许会不同，根据面包机的MVNO来取
// keep it  协议的位置：  /MiFiRent/DHIRental/keepit_agreement_en_DHI.json  /MiFiRent/DHIRental/keepit_agreement_zh-cn_DHI.json    和租赁协议一样， 每个MVNO或许会不同，根据面包机的MVNO来取

final routes = {
  ROOT: (context) => MyApp(),
  PAY:  (context, {arguments}) => PayPage(arguments),
  RENT: (context) => RentPage(),
  RENT_FAIL: (pageName) => RentFailPage(),
  DEVICE: (pageName, {arguments}) => DevicePage(arguments),
  FAULR_REPORT: (pageName, {arguments}) => FaultReporting(arguments),
  PROBLEM: (pageName) => ProblemPage(),
  FLOW_PACKAGE: (pageName, {arguments}) => FlowPackagePage(arguments),
  SUCCESS: (pageName, {arguments}) => SuccessPage(arguments),
  QUERY: (pageName, {arguments}) => QueryPage(arguments),
  PAY_FAIL: (pageName, {arguments}) => PayFailPage(arguments),
  FLOW_PACKAGE_PAY: (pageName, {arguments}) => FlowPackagePayPage(arguments),
};

// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings) {
    final String name = settings.name;
    final Function pageContentBuilder = routes[name];
    if (pageContentBuilder != null) {
      if (settings.arguments != null) {
        final Route route = MaterialPageRoute(
          settings: RouteSettings(name: name),
          builder: (context) => pageContentBuilder(context, arguments: settings.arguments)
        );
        return route;
      } else {
        final Route route = MaterialPageRoute(
            settings: RouteSettings(name: name),
            builder: (context) => pageContentBuilder(context)
        );
        return route;
      }
    }
    return MaterialPageRoute(
        settings: RouteSettings(name: name),
        builder: (context) => pageContentBuilder(context)
    );
};

void main() async {

  FlutterError.onError = (FlutterErrorDetails details) {
    ULog.e(details.toString());
  };
  runZoned(
          () => runApp(
          MaterialApp(
            title: 'mifi_rental',
            theme: ThemeData(
                primarySwatch: Colors.blue, primaryColor: color_bg_main,primaryColorBrightness:Brightness.light),
            localizationsDelegates: [
              MyLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            // ignore: missing_return
            localeResolutionCallback: (deviceLocal, supportLocals) {
              if (Platform.isAndroid) {
                SharedPreferenceUtil.saveNativeLocal({
                  "languageCode": deviceLocal.languageCode,
                  "countryCode": deviceLocal.countryCode
                });
                ULog.i("deviceLocal: ${deviceLocal.toString()}");
              }
            },
            supportedLocales: [
              const Locale('en'),
              const Locale('zh', 'CN'),
              const Locale('zh', 'HK'),
              const Locale('zh', 'TW'),
            ],
            initialRoute: ROOT,
            onGenerateRoute: onGenerateRoute,
          )),
      zoneSpecification: ZoneSpecification(),
      onError: (Object obj, StackTrace stack) {
        ULog.e(obj.toString() + stack.toString());
      }
  );

  await initAppData();
}

Future<void> initAppData() async {
  if (Platform.isIOS) {
    SharedPreferenceUtil.saveNativeLocal(
        await NativeSystemDefaultConfig.nativeDefaultLanguage);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Order _currentOrder;
  bool _loading = true;
  bool _orderQuerySuccess = false;

  @override
  void initState() {
    super.initState();
    BaseOptions options = BaseOptions(
      baseUrl: UrlApi.BASE_HOST,
      responseType: ResponseType.plain,
      receiveDataWhenStatusError: true,
      connectTimeout: 15000,
      receiveTimeout: 3000,
    );
    var dio = Dio(options);

    NetConfigurator.singleton
        .setAdapter(MRDioAdapter(dio))
        .setRequestProxy(RequestProxy())
        .setResponseProxy(ResponseProxy())
        .setErrorProxy(ErrorProxy())
        .configure();

    _queryUseOrder();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingPageUtil(
        loading: _loading,
        child: _content(_currentOrder)
    );
  }

  Widget _content(Order o) {
    if (_loading) {
      return Container(
        color: Colors.white,
      );
    } else {
      if (_orderQuerySuccess) {
        if (o != null) {
          if (o.orderStatus == OrderStatus.IN_USING || (o.orderStatus == OrderStatus.IN_ORDER && o.payStatus == PayStatus.PAYED)) {
            return DevicePage(o);
          } else {
              return RentPage();
          }
        } else {
          return RentPage();
        }
      } else {
        return NetExceptionPage(() {
            _queryUseOrder();
        });
      }
    }
  }

  Future<void> _queryUseOrder() async {
    ULog.d('查询正在使用订单');
    await OrderRepository.queryOrderInfo(
      pay: false,
      success: ((o) {
        setState(() {
          _currentOrder = o;
          _loading = false;
          _orderQuerySuccess = true;
        });
      }),
      error: ((e) {
        if(e is NetException && e.code == "00000045") {
          setState(() {
            _currentOrder = null;
            _loading = false;
            _orderQuerySuccess = true;
          });
        } else {
          setState(() {
            _currentOrder = null;
            _loading = false;
            _orderQuerySuccess = false;
          });
        }
      }),
    );
  }
}

