import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/dialog/privacy_policy.dart';
import 'package:mifi_rental/dialog/user_agreement.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/device/device_provider.dart';
import 'package:mifi_rental/page/device/refresh_provider.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:provider/provider.dart';

import 'goods_provider.dart';
import 'notify_provider.dart';
import 'order_provider.dart';

class DevicePage extends BasePage {
  @override
  Widget doBuild(BuildContext context, Widget scaffold) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => getProvider<DeviceProvider>()),
      ChangeNotifierProvider(create: (_) => getProvider<OrderProvider>()),
      ChangeNotifierProvider(create: (_) => getProvider<GoodsProvider>()),
      ChangeNotifierProxyProvider<NotifyProvider, RefreshProvider>(
        create: (_) => getProvider<RefreshProvider>(),
        update: (_, notifyProvider, refreshProvider) {
          if (notifyProvider.refreshState) {
            refreshProvider.refreshData();
            notifyProvider.refreshState = false;
          }
          return refreshProvider;
        },
      ),
    ], child: scaffold);
  }

  @override
  List<BaseProvider> setProviders() {
    var refreshProvider = RefreshProvider();
    return [
      refreshProvider,
      refreshProvider.deviceProvider,
      refreshProvider.goodsProvider,
      refreshProvider.orderProvider,
    ];
  }

  @override
  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: color_bg_FFFFFF,
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
              value: "userAgreement",
            ),
            PopupMenuItem<String>(
              child: Center(
                child: Text(
                  MyLocalizations.of(context).getString(privacy_policy),
                  style: TextStyle(fontSize: sp_14, color: color_text_333333),
                ),
              ),
              value: "privacyPolicy",
            ),
          ],
          onSelected: (String action) {
            switch (action) {
              case "userAgreement":
                UserAgreementDialog().show(context);
                break;
              case "privacyPolicy":
                PrivacyPolicyDialog().show(context);
                break;
            }
          },
        ),
      ],
    );
  }

  @override
  Widget setBody(BuildContext context) {
    return Container(
        color: color_bg_FFFFFF,
        child: ListView(
          children: <Widget>[
            _Refresh(),
            _DataInfo(),
            _OrderInfo(),
            _Buy(),
            Container(
              height: 10,
              color: color_bg_main,
            ),
            _DeviceInfo(),
          ],
        ));
  }
}

class _DeviceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceProvider orderProvider = Provider.of<DeviceProvider>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(dp_frame, 15, dp_frame, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            MyLocalizations.of(context).getString(device_info),
            style: TextStyle(fontSize: sp_16, color: color_text_333333),
          ),
          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    MyLocalizations.of(context).getString(wifi_name),
                    style: TextStyle(color: color_text_333333, fontSize: sp_14),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      orderProvider.wifiName ?? '',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: sp_14, color: color_text_999999),
                    ),
                  )
                ],
              )),
          Container(
            height: dp_line,
            color: color_line,
          ),
          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    MyLocalizations.of(context).getString(wifi_password),
                    style: TextStyle(color: color_text_333333, fontSize: sp_14),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      orderProvider.wifiPwd ?? '',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: sp_14, color: color_text_999999),
                    ),
                  )
                ],
              )),
          Container(
            height: dp_line,
            color: color_line,
          ),
          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    MyLocalizations.of(context).getString(imei),
                    style: TextStyle(color: color_text_333333, fontSize: sp_14),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      orderProvider.imei ?? '',
                      textAlign: TextAlign.end,
                      style:
                          TextStyle(fontSize: sp_14, color: color_text_999999),
                    ),
                  )
                ],
              )),
          Container(
            height: dp_line,
            color: color_line,
          ),
          Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      onPressed: () {
                        FlutterBoost.singleton.open(FAULR_REPORT, exts: {"animated":true});
                      },
                      color: color_theme,
                      child: Text(
                        MyLocalizations.of(context).getString(trouble_report),
                        style: TextStyle(
                            fontSize: sp_16, color: color_text_FFFFFF),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)))))
        ],
      ),
    );
  }
}

class _Buy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(dp_frame, 15, dp_frame, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            MyLocalizations.of(context).getString(if_like_device),
            style: TextStyle(fontSize: sp_14, color: color_text_333333),
          ),
          Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: <Widget>[
                  Flexible(
                      fit: FlexFit.tight,
                      child: FlatButton(
                        child: Text(
                          MyLocalizations.of(context)
                              .getString(buy_this_device),
                          style: TextStyle(fontSize: sp_16, color: color_theme),
                        ),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: color_theme),
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                  Container(
                    width: 20,
                  ),
                  Flexible(
                      fit: FlexFit.tight,
                      child: FlatButton(
                        child: Text(
                          MyLocalizations.of(context).getString(buy_new_device),
                          style: TextStyle(fontSize: sp_16, color: color_theme),
                        ),
                        onPressed: () {},
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: color_theme),
                            borderRadius: BorderRadius.circular(5.0)),
                      )),
                ],
              )),
        ],
      ),
    );
  }
}

class _OrderInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    return Padding(
      padding: EdgeInsets.only(right: dp_frame, left: dp_frame),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          orderProvider.usedTmStr ?? '',
                          style: TextStyle(fontSize: sp_18, color: color_theme),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              MyLocalizations.of(context)
                                  .getString(lease_duration),
                              style: TextStyle(
                                  fontSize: sp_14, color: color_text_999999),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: dp_line,
                    color: color_line,
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          orderProvider.shouldPay ?? '',
                          style: TextStyle(fontSize: sp_18, color: color_theme),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              MyLocalizations.of(context)
                                  .getString(buckle_amount),
                              style: TextStyle(
                                  fontSize: sp_14, color: color_text_999999),
                            ))
                      ],
                    ),
                  )
                ],
              )),
          Container(
            width: double.infinity,
            height: dp_line,
            color: color_line,
          ),
          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    MyLocalizations.of(context).getString(lease_date),
                    style: TextStyle(fontSize: sp_14, color: color_text_333333),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      orderProvider.rentDate ?? '',
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              )),
          Container(
            width: double.infinity,
            height: dp_line,
            color: color_line,
          ),
          Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: <Widget>[
                  Text(
                    MyLocalizations.of(context).getString(device_deposit),
                    style: TextStyle(fontSize: sp_14, color: color_text_333333),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    child: Text(
                      '\$${orderProvider.deposit}',
                      textAlign: TextAlign.end,
                    ),
                  )
                ],
              )),
          Container(
            width: double.infinity,
            height: dp_line,
            color: color_line,
          ),
        ],
      ),
    );
  }
}

class _Refresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RefreshProvider refreshProvider = Provider.of<RefreshProvider>(context);
    return Padding(
        padding:
            EdgeInsets.only(left: dp_frame, right: dp_frame, top: 5, bottom: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Text(
              MyLocalizations.of(context).getString(last_update),
              style: TextStyle(fontSize: sp_12, color: color_text_999999),
            ),
            Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(refreshProvider.date ?? '',
                      style:
                          TextStyle(fontSize: sp_12, color: color_text_999999)),
                )),
            FlatButton(
              child: Text(
                MyLocalizations.of(context).getString(refresh),
                style: TextStyle(fontSize: sp_16, color: color_text_333333),
              ),
              onPressed: () {
                refreshProvider.refreshData(showLoad: true);
              },
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: color_line),
                  borderRadius: BorderRadius.circular(20.0)),
            ),
          ],
        ));
  }
}

class _DataInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return Stack(
      children: <Widget>[
        Positioned(
            top: 0,
            left: 0,
            child: Material(
                color: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage('images/faq.png'))),
                  child: InkWell(
                    borderRadius: new BorderRadius.circular(40.0),
                    onTap: () {
                      FlutterBoost.singleton.open(PROBLEM, exts: {'animated': true});
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                    ),
                  ),
                ))),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
              color: Colors.transparent,
              child: Ink(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/online_service.png'))),
                child: InkWell(
                  borderRadius: new BorderRadius.circular(40.0),
                  onTap: () {},
                  child: Container(
                    width: 80,
                    height: 80,
                  ),
                ),
              )),
        ),
        Center(
          child: Padding(
              padding: EdgeInsets.only(top: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      width: 150,
                      height: 150,
                      color: color_theme,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                goodsProvider.surplusFlow ?? '--',
                                style: TextStyle(
                                    fontSize: 50, color: color_text_FFFFFF),
                              ),
                              Text(
                                goodsProvider.unit ?? '',
                                style: TextStyle(
                                    fontSize: 20, color: color_text_FFFFFF),
                              )
                            ],
                          ),
                          Text(
                            MyLocalizations.of(context).getString(surplus_data),
                            style: TextStyle(
                                color: color_text_FFFFFF, fontSize: sp_12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: FlatButton(
                          onPressed: () {
                            FlutterBoost.singleton.open(FLOW_PACKAGE, exts: {"animated":true});
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                MyLocalizations.of(context).getString(buy_data),
                                style: TextStyle(
                                    fontSize: sp_14, color: color_theme),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Image.asset('images/arrow_right.png'),
                              )
                            ],
                          ))),
                ],
              )),
        ),
      ],
    );
  }
}
