import 'package:barcode_scan/barcode_scan.dart';
import 'package:core_log/core_log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/preference_key.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/dialog/privacy_policy.dart';
import 'package:mifi_rental/dialog/tips_dialog.dart';
import 'package:mifi_rental/dialog/user_agreement.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/pay/pay_page.dart';
import 'package:mifi_rental/page/problem/problem_page.dart';
import 'package:mifi_rental/page/rent/rent_provider.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/connect_util.dart';
import 'package:mifi_rental/util/route_util.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';
import 'package:permission_handler/permission_handler.dart';

class RentPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RentPageState();
  }

//  @override
//  Widget doBuild(BuildContext context, Widget scaffold) {
//    return scaffold;
//  }

//  @override
//  List<BaseProvider> setProviders() {
//    return [RentProvider()];
//  }
//
//  @override
//  Widget setBody(BuildContext context) {
//    return _Body();
//  }
}

class RentPageState extends State<RentPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: _Body()
    );
  }

  PreferredSizeWidget _appbar(BuildContext context) {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      title: Text(
        MyLocalizations.of(context).getString(home_page),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(
            Icons.more_horiz,
            color: color_bg_333333,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
            PopupMenuItem<String>(
              child: Center(
                child: Text(
                  MyLocalizations.of(context).getString(user_agreement),
                  style: TextStyle(fontSize: sp_14, color: color_text_333333),
                ),
              ),
              value: 'userAgreement',
            ),
            PopupMenuItem<String>(
              child: Center(
                child: Text(
                  MyLocalizations.of(context).getString(privacy_policy),
                  style: TextStyle(fontSize: sp_14, color: color_text_333333),
                ),
              ),
              value: 'privacyPolicy',
            ),
          ],
          onSelected: (String action) {
            switch (action) {
              case 'userAgreement':
                _showUserAgreement(context);
                break;
              case 'privacyPolicy':
                PrivacyPolicyDialog().show(context);
                break;
            }
          },
        ),
      ],
    );
  }

  _showUserAgreement(BuildContext context) async {
    bool agree = await SharedPreferenceUtil.getBool(USER_AGREEMENT) ?? false;
    UserAgreementDialog().show(context, showActions: !agree);
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: color_bg_FFFFFF,
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset('images/device.png')),
            Expanded(
                child: Stack(
              children: <Widget>[
                Positioned(
                  left: 0,
                  bottom: 0,
                  child: Material(
                      color: Colors.transparent,
                      child: Ink(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('images/faq.png'))),
                          child: InkWell(
                            borderRadius: new BorderRadius.circular(40.0),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                return ProblemPage();
                              }));
                            },
                            child: Container(
                              width: 80,
                              height: 80,
                            ),
                          ))),
                ),
                Center(child: _Scan())
              ],
            ))
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
        ));
  }
}

class _Scan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
            color: color_bg_FFFFFF,
            child: Ink(
                decoration: BoxDecoration(
                  color: color_theme, // 背景色
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: new BorderRadius.circular(75.0),
                  onTap: () {
                    _scan(context);
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/scan.png'),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            MyLocalizations.of(context).getString(scan),
                            style: TextStyle(
                                color: color_text_FFFFFF, fontSize: sp_12),
                          ),
                        )
                      ],
                    ),
                  ),
                ))),
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: Text(
            MyLocalizations.of(context).getString(scan_wifi_rental),
            style: TextStyle(color: color_theme, fontSize: sp_12),
          ),
        )
      ],
    );
  }

  _scan(BuildContext context) async {
    bool agree = await SharedPreferenceUtil.getBool(USER_AGREEMENT) ?? false;
    if (!agree) {
      UserAgreementDialog().show(context, showActions: !agree);
    } else {
      ConnectUtil.isConnected().then((b) {
        if (!b) {
          TipsDialog().show(context,
              MyLocalizations.of(context).getString(network_exceptions));
          return;
        }
        _doScan(context);
      });
    }
  }

  void _doScan(BuildContext context) async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      if (result.type == ResultType.Barcode) {
        if (result.rawContent.contains('rental.ukelink.net')) {
          try {
            var sn = result.rawContent.substring(
                result.rawContent.indexOf('=') + 1, result.rawContent.length);
            ULog.i('sn: $sn');
//            if (Platform.isAndroid) {
//              RouteUtil.openFlutter(PAY, urlParams: {'sn': sn});
//            } else {
////              FlutterBoost.singleton.open(PAY, urlParams: {'sn': sn}, exts: {"animated": true});
//            }
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return PayPage(sn);
            }));
          } catch (e) {
            ULog.e(e.toString());
          }
        }
      }
      print(result.type); // The result type (barcode, cancelled, failed)
      print(result.rawContent); // The barcode content
      print(result.format); // The barcode format (as enum)
      print(result
          .formatNote); // If a unknown format was scanned this field contains a note
    } on PlatformException catch (e) {} on FormatException {} catch (e) {}
  }

  Future<bool> requestPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
    ]);
    return permissions[PermissionGroup.camera] == PermissionStatus.granted;
  }
}
