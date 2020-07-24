import 'dart:convert';

import 'package:core_log/core_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mifi_rental/entity/auth_paypal.dart';
import 'package:mifi_rental/entity/flow_packages.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/flow_package_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/net_util.dart';

class FlowPackagePayPage extends StatefulWidget {
  final Map map;
  FlowPackagePayPage(this.map);

  @override
  State<StatefulWidget> createState() => FlowPackagePayPageState();
}

class FlowPackagePayPageState extends State<FlowPackagePayPage> with AutomaticKeepAliveClientMixin {
  DataList dataList;
  String imei;
  String mvnoCode;

  @override
  void initState() {
    super.initState();

    this.dataList = widget.map['data'];
    this.imei = widget.map['imei'];
    this.mvnoCode = widget.map['mvnoCode'];
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        child: Scaffold(
          appBar: setAppbar(context),
          body: setBody(context),
        )
    );
  }

  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text(
        MyLocalizations.of(context).getString(pay),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
//            FlutterBoost.singleton.closeCurrent();
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: color_bg_333333,
          )),
    );
  }

  Widget setBody(BuildContext context) {
    return Container(
      color: color_bg_FFFFFF,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
              child: ListView(
                children: <Widget>[
                  Padding (
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 44,
                      child: Text("加油包信息",
                        style: TextStyle(
                            color: color_bg_333333,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                  ),
                  Padding (
                      padding: EdgeInsets.only(left: 16.0, right: 0.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 49.5,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text('加油包流量', style: TextStyle(fontSize: 14, color: color_bg_333333)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                    child: Text('10G', style: TextStyle(fontSize: 14, color: color_bg_333333)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: color_text_E0E0E0,
                              height: 0.5,
                            )
                          ],
                        )
                      )
                  ),
                  Padding (
                      padding: EdgeInsets.only(left: 16.0, right: 0.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 49.5,
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text('原价', style: TextStyle(fontSize: 14, color: color_bg_333333)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                                    child: Text(dataList.currencyType + ' ' + dataList.goodsPrice, style: TextStyle(fontSize: 14, color: color_bg_333333)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              color: color_text_E0E0E0,
                              height: 0.5,
                            )
                          ],
                        ),
                      )
                  ),
                  Padding (
                      padding: EdgeInsets.only(left: 16.0, right: 0.0),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text('优惠金额', style: TextStyle(fontSize: 14, color: color_bg_333333)),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 16.0, right: 16.0),
                              child: Text(_discountsPrice(),
                                  style: TextStyle(fontSize: 14, color: color_text_F5A623)),
                            )
                          ],
                        ),
                      )
                  ),

                  Container(height: 10, color: color_bg_main),
                  _PayType(),
                ],
            )
          ),
          Container(
            height: dp_line,
            color: color_line,
          ),
          _Pay(dataList, imei, mvnoCode),
        ],
      ),
    );
  }

  String _discountsPrice() {
    String value = dataList.discountPrice != null ?
    '${(double.parse(dataList.goodsPrice) - double.parse(dataList.discountPrice))}'
        : '0.00';
    return dataList.currencyType + ' ' + value;
  }
}

class _PayType extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(dp_frame, 15, dp_frame, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              MyLocalizations.of(context).getString(pay_type),
              style: TextStyle(fontSize: sp_16, color: color_text_333333),
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.tight,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset('images/paypal.png'),
                          Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      MyLocalizations.of(context).getString(paypal),
                                      style: TextStyle(
                                          fontSize: sp_16,
                                          color: color_text_333333),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(top: 5),
                                        child: Text(
                                          MyLocalizations.of(context)
                                              .getString(paypal_tip),
                                          style: TextStyle(
                                              fontSize: sp_12,
                                              color: color_text_999999),
                                        ))
                                  ],
                                ),
                              ))
                        ],
                      ),
                    ),
                    Image.asset('images/selected.png'),
                  ],
                ))
          ],
        ));
  }
}

class _Pay extends StatelessWidget {
  final DataList data;
  final String imei;
  final String mvnoCode;
  _Pay(this.data, this.imei, this.mvnoCode);

  static const MethodChannel methodChannel = MethodChannel("com.uklink.common/methodChannel");

  static const EventChannel eventChannel = EventChannel("com.uklink.common/payPageState");

  String _priceString() {
    String price = data.discountPrice != null ?
    '${(double.parse(data.goodsPrice) - double.parse(data.discountPrice))}'
        : data.goodsPrice;
    return data.currencyType + ' ' + price;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: EdgeInsets.only(left: dp_frame, bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.ideographic,
                children: <Widget>[
                  Text(
                    MyLocalizations.of(context).getString(pay_amount),
                    style: TextStyle(fontSize: sp_14, color: color_text_666666),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        _priceString(),
                        style: TextStyle(fontSize: sp_24, color: color_theme),
                      )),
                ],
              ),
            )),
        Material(
            child: Ink(
              decoration: BoxDecoration(color: color_theme),
              child: InkWell(
                  onTap: () {
                    // 创建订单后去支付
                    _preCalcOrder(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(30, 15, 30, 15),
                      child: Text(
                        MyLocalizations.of(context).getString(go_pay),
                        style: TextStyle(fontSize: sp_16, color: color_text_FFFFFF),
                      ))),
            )),
      ],
    );
  }

  _preCalcOrder(BuildContext context) {
    FlowPackageRepository.queryBindingToken(imei,
            (tokenData) {
                if (tokenData is Map && tokenData["token"] != null) {
                  FlowPackageRepository.preCalcOrder(data.currencyType,
                      tokenData["customerId"],
                      tokenData["token"],
                      {'goodsId':data.goodsId, "quanity":data.quantity, "effectiveTime":0, "expireTime":0},
                          (calcData) {
                        if (calcData is Map) {
                          _createFlowPackageOrder(
                              calcData,
                              tokenData["customerId"],
                              tokenData["token"],
                              success: (value) {
                                _gotoPayWebview(value,  tokenData["customerId"], tokenData["token"], context);
                              },
                              failure: (e) {

                              });
                        }
                      },
                          (e) {

                      });
                } else {
                  // 失败
                }
            },
            (e) {
                // 失败
            });
  }
  _createFlowPackageOrder(
      Map map,
      String customId,
      String accessToken,
      {Function(dynamic) success,
      Function(dynamic) failure}) {
    List goodsList = map["goodsList"];
    if (map["payCurrencyType"] != null && goodsList != null && goodsList.length > 0) {
      FlowPackageRepository.createFlowPackageOrder(
          map["payCurrencyType"],
          customId,
          accessToken,
          {'goodsId':goodsList[0]["goodsId"],
            "quanity":'1',
            "effectiveTime":goodsList[0]["effectiveTime"],
            "expireTime":goodsList[0]["expireTime"]
          },
          (value) {
            // 流量包订单创建成功
            success(value);
          }, (e) {
            // 流量包订单创建失败
            failure(e);
      });
    } else {

    }
  }

  _gotoPayWebview(Map map, String customerId, String accessToken, BuildContext context) {
//    {"orderSN":"20200716082946971136022","amount":0.0,"currencyType":"USD","orderDesc":"面包机30M","orderId":"5f100ffa5a410e6802b31a0a","deductInfo":null}
    var authPaypal = AuthPaypal(
      totalAmount: (map["amount"].toInt()).toString(),
      loginCustomerId: customerId,
      orderSn: map["orderSN"],
      streamNo: NetUtil.getSteamNo(),
      currencyCode: map["currencyType"],
      langType: MyLocalizations.of(context).getLanguage(),
      mvnoCode: mvnoCode,
      localeCode: MyLocalizations.of(context).getLanguage().replaceAll('-', '_'),
      projectName: 'authPaypal.App.$mvnoCode',
    );

  Map<String, dynamic> params = {
    "productName" : data.goodsName  ?? '',
    "price" : data.goodsPrice  ?? '',
    "quanity" : '1',
    "productCurrencyType" : map["currencyType"] ?? '',
    "access_token" : accessToken ?? '',
    "projectName": 'authPaypal.App.$mvnoCode' ?? '',
    "payType": 'flow_package',
    "paypalUrl": UrlApi.PAYPAL_HOST
  };
    String json = jsonEncode(authPaypal);
    var maps = authPaypal.toJson();
    maps.addAll(params);
    ULog.d(maps.toString());

  platformMethod("payWebPage", arguments: maps);
  // 监听native回调
  eventChannel.receiveBroadcastStream().listen(_onEvent,
      onError: _onError,
      onDone: (){},
      cancelOnError: true);

//    var authPaypal = AuthPaypal(
//      totalAmount: any.deposit.toString(),
//      loginCustomerId: any.customerId,
//      orderSn: any.orderSn,
//      streamNo: NetUtil.getSteamNo(),
//      currencyCode: any.currencyCode,
//      langType: MyLocalizations.of(context).getLanguage(),
//      mvnoCode: any.mvnoCode,
//      localeCode:
//      MyLocalizations.of(context).getLanguage().replaceAll('-', '_'),
//      projectName: 'authPaypal.App.${any.mvnoCode}',
//    );
//    String json = jsonEncode(authPaypal);
//    ULog.d(json);
//    var map = authPaypal.toJson();
//    map.addAll({"terminalSn": terminalSn, "paypalUrl": UrlApi.PAYPAL_HOST});
//    platformMethod("payWebPage", arguments: map);
  }


  Future<void> platformMethod(String methodName, {dynamic arguments}) async {
    try {
      final int result = await methodChannel.invokeMethod(methodName, arguments);
    } on PlatformException {

    }
  }

  void _onEvent(Object event) {
    var message = event as Map;

  }

  void _onError(Object error) {

  }
}