import 'dart:collection';

import 'package:core_log/core_log.dart';
import 'package:core_net/net_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/alert_util.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/dialog/privacy_policy.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/page/device/device_provider.dart';
import 'package:mifi_rental/page/device/refresh_provider.dart';
import 'package:mifi_rental/repository/conf_repository.dart';
import 'package:mifi_rental/repository/device_repository.dart';
import 'package:mifi_rental/repository/order_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';
import 'package:provider/provider.dart';

import 'goods_provider.dart';
import 'order_provider.dart';

class DevicePage extends StatefulWidget {
  final Order order;
  DevicePage(this.order);

  @override
  State<StatefulWidget> createState() => DevicePageState();
}

class DevicePageState extends State<DevicePage> with AutomaticKeepAliveClientMixin {
  final HashMap<String, BaseProvider> _providers = HashMap();
  final _globalKey = GlobalKey<ScaffoldState>();
  RefreshProvider _refreshProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (_refreshProvider == null) {
      _refreshProvider = RefreshProvider(widget.order, context);
    }
    var scaffold = SafeArea(
        top: false,
        child: Scaffold(
          key: _globalKey,
          appBar: setAppbar(context),
          body: setBody(context),
        )
    );
    return doBuild(context, scaffold);
  }

  Widget doBuild(BuildContext context, Widget scaffold) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => _refreshProvider),
          ChangeNotifierProvider(create: (_) => _refreshProvider.deviceProvider),
          ChangeNotifierProvider(create: (_) => _refreshProvider.orderProvider),
          ChangeNotifierProvider(create: (_) => _refreshProvider.goodsProvider),
        ],
        child: scaffold);
  }

  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
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
                CustomBottomSheetDialog.show(context, BottomSheetType.user_agreement);
                break;
              case "privacyPolicy":
                CustomBottomSheetDialog.show(context, BottomSheetType.privacy_policy);
                break;
            }
          },
        ),
      ],
    );
  }

  Widget setBody(BuildContext context) {
    return Container(
        color: color_bg_FFFFFF,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            _Refresh(),
            _DataInfo(),
            _OrderInfo(),
            _Buy(widget.order),
            Container(
              height: 10,
              color: color_bg_main,
            ),
            _DeviceInfo(),
          ],
        ));
  }
}

class _Refresh extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RefreshProvider refreshProvider = Provider.of<RefreshProvider>(context);
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: dp_frame),
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
                      style: TextStyle(fontSize: sp_12, color: color_text_999999)),
                )),
            Container(
              height: 30.0,
              width: 60.0,
              child: FlatButton(
                child: Text(
                  MyLocalizations.of(context).getString(refresh),
                  style: TextStyle(fontSize: sp_14, color: color_text_333333),
                ),
                onPressed: () {
                  _queryUseOrder((order) {
                    refreshProvider.refreshData(showLoad: true, order: order);
                  }, (e) {
                    if (e is NetException) {
                      if (e.code == "00000045") {
                        Navigator.of(context).pushReplacementNamed(RENT);
                      }
                    }
                  });
                },
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: color_line),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ));
  }
  Future<void> _queryUseOrder(Function(Order) success, Function(dynamic) failure) async {
    ULog.d('设备界面查询正在使用订单');
    await OrderRepository.queryOrderInfo(
      pay: false,
      success: ((o) {
        success(o);
      }),
      error: ((e) {
        failure(e);
      }),
    );
  }
}

class _DeviceInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DeviceProvider deviceProvider = Provider.of<DeviceProvider>(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(dp_frame, 15, dp_frame, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            MyLocalizations.of(context).getString(device_info),
            style: TextStyle(fontSize: sp_16, color: color_text_333333, fontWeight: FontWeight.w700),
          ),
          Padding(
              padding: EdgeInsets.only(top: 25, bottom: 15),
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
                      deviceProvider.wifiName ?? '',
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
                      deviceProvider.wifiPwd ?? '',
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
                      deviceProvider.imei ?? '',
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
                        Navigator.of(context).pushNamed(FAULR_REPORT, arguments: {"imei": deviceProvider.imei ?? '', "orderSn": deviceProvider.order.orderSn ?? ''});
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

class _Buy extends StatefulWidget {
  Order order;
  _Buy(this.order);
  @override
  State<StatefulWidget> createState() => _BuyState();
}

class _BuyState extends State<_Buy> {
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
              padding: EdgeInsets.only(top: 12),
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
                        onPressed: () {
                            _showBuyDialog(context, widget.order.mvnoCode);
                        },
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
  
  _showBuyDialog(BuildContext context, String mvno) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return _BuyAlertPage(widget.order);
        }
    );
  }
}

class _BuyAlertPage extends StatefulWidget {
  final Order order;
  _BuyAlertPage(this.order);
  @override
  State<StatefulWidget> createState() => BuyAlertPageState();
}

class BuyAlertPageState extends State<_BuyAlertPage> {
  bool _agree = true;
  String _ruleStr = '';

  @override
  void initState() {
    _getRuleStr();
    super.initState();
  }

  void _getRuleStr() async {
     await ConfigRepository.getConfByMvno(
        mvnoCode: widget.order.mvnoCode,
        success: ((config) {
          final String language = SharedPreferenceUtil.nativeLocal.languageCode + "-" + SharedPreferenceUtil.nativeLocal.countryCode;
          String file = language.startsWith('zh') ? 'keepit_agreement_${language.toLowerCase()}.json' : 'keepit_agreement_en.json';
          String url = '${UrlApi.DOCUMENT_HOST}MiFiRent/DHIRental/' + file;
          Dio().get(url).then((Response response){
            if (response.data is Map) {
              if (mounted) {
                setState(() {
                  String dataStr = response.data["data"];
                  dataStr = dataStr.replaceAll(
                      '\${currencyType}', config.currencyType + ' ');
                  dataStr = dataStr.replaceAll('\${salePrice}',
                      (double.parse(config.salePrice) / 100).toStringAsFixed(
                          2));
                  List<String> arr = dataStr.split('\n');
                  String temp = '';
                  for (int i = 1; i < arr.length; i++) {
                    temp += arr[i] + '\n';
                  }
                  _ruleStr = temp;
                });
              }
            }
          },
          onError: (e) {
            ULog.e(e.toString());
          });
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: GestureDetector(
          onTap: () {Navigator.of(context).pop();},
          child: Container(
            alignment: Alignment.center,
            color: Color.fromARGB(122, 0, 0, 0),
            child: GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  constraints: BoxConstraints(minHeight: 360.0, maxHeight: 360.0),
                  decoration: BoxDecoration(
                    color: color_text_FFFFFF,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text("购买协议", style: TextStyle(fontSize: 16.0, color: color_bg_333333, fontWeight: FontWeight.w700, decoration: TextDecoration.none),),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Container(
                            height: MediaQuery.of(context).size.height / 4.0,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: <Widget>[
                                Text(_ruleStr,
                                  style: TextStyle(fontSize: 14.0, color: color_text_666666, decoration: TextDecoration.none),
                                )
                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Container(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                  activeColor: color_text_5099CC,
                                  value: _agree,
                                  onChanged: (selected){
                                    setState(() {
                                      _agree = !_agree;
                                    });
                                  }),
                              Text("已查阅并同意该购买协议", style: TextStyle(fontSize: 14, color: color_text_333333),),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: RaisedButton(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                onPressed: () {
                                    _gotoBuyMiFi();
                                },
                                color: color_theme,
                                child: Text(
                                  "购买",
                                  style: TextStyle(
                                      fontSize: sp_16, color: color_text_FFFFFF),
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0))),
                          )
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  _gotoBuyMiFi() {
    Navigator.of(context).pop();

    if (_agree) {
      // 支付
      AlertUtil.showNetLoadingDialog(context);
      DeviceRepository.buyMifi(widget.order.orderSn, (value) {
        AlertUtil.dismissNetLoading(context);

        _showBuySuccessAlert();
      }, (e) {
        AlertUtil.dismissNetLoading(context);
        if (e is NetException && e.code == "99999999") {
          ULog.e("购买设备支付失败，默认按照购买成功处理");
          _showBuySuccessAlert();
        } else {
          Fluttertoast.showToast(msg: "购买失败",
              textColor: Colors.white,
              backgroundColor: Colors.black,
              fontSize: 14.0,
              gravity: ToastGravity.CENTER);
        }
      });
    } else {
      Fluttertoast.showToast(msg: "请先勾选购买协议", textColor: Colors.white, backgroundColor: Colors.black, fontSize: 14.0);
    }
  }

  _showBuySuccessAlert() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return SimpleDialog(
            titlePadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.all(0),
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 8),
                    child: Text('您已成功购买了该设备！', style: TextStyle(fontSize: 16, color: color_text_333333)),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: 45,
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text('请下载GlocalMe app管理您的设备吧', textAlign: TextAlign.center, style: TextStyle(fontSize: 12, color: color_text_999999)),
                  )
                ],
              ),
              Container(
                height: 43.0,
                decoration: BoxDecoration(
                    color: color_bg_F5F5F5,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4.0), bottomRight: Radius.circular(4.0))
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: FlatButton(
                        highlightColor: color_bg_F5F5F5,
                        splashColor: color_bg_F5F5F5,
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushNamedAndRemoveUntil(RENT, (Route<dynamic> route) => false);
                        },
                        child: Text("等会下载", style: TextStyle(fontSize: 16, color: color_text_333333),),
                      ),
                    ),
                    Container(
                      width: 1,
                      color: Colors.white,
                    ),
                    Expanded(
                        flex: 1,
                        child: FlatButton(
                          highlightColor: color_bg_F5F5F5,
                          splashColor: color_bg_F5F5F5,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamedAndRemoveUntil(RENT, (Route<dynamic> route) => false);
                          },
                          child: Text('立即下载', style: TextStyle(fontSize: 16, color: color_bg_5099CC)),
                        )
                    )
                  ],
                ),
              )
            ],
          );
        }
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
              padding: EdgeInsets.only(top: 30, bottom: 15),
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
                      orderProvider.deposit ?? '',
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
          GestureDetector(
            onTap: () {

            },
            child: Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Flex(
                  direction: Axis.horizontal,
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          "我的加油包",
                          style: TextStyle(fontSize: sp_14, color: color_text_333333),
                        )
                    ),
                    Image.asset('images/arrow_right.png'),
                  ],
                )
            ),
          ),
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

class _DataInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoodsProvider goodsProvider = Provider.of<GoodsProvider>(context);
    return Stack(
      children: <Widget>[
        Positioned(
            top: 23,
            left: dp_frame,
            child: Material(
                color: Colors.transparent,
                child: Ink(
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('images/faq.png'))),
                  child: InkWell(
                    borderRadius: new BorderRadius.circular(40.0),
                    onTap: () {
                        Navigator.of(context).pushNamed(PROBLEM);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                ))),
        // 客服按钮
        Positioned(
          top: 23,
          right: dp_frame,
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
                    width: 40,
                    height: 40,
                  ),
                ),
              )),
        ),
        Center(
          child: Padding(
              padding: EdgeInsets.only(top: 47),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 2 / 5.0,
                      height: MediaQuery.of(context).size.width * 2 / 5.0,
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
                                    fontSize: 50,
                                    color: color_text_FFFFFF,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 12),
                                child: Text(
                                    goodsProvider.unit ?? '',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color.fromRGBO(255, 255, 255, 0.5),
                                        fontWeight: FontWeight.w700
                                    )
                                ),
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
                      padding: EdgeInsets.only(top: 20),
                      child: FlatButton(
                          onPressed: () {
                            // 购买加油包
                              Navigator.of(context).pushNamed(FLOW_PACKAGE, arguments: {'mvnoCode': goodsProvider.order.mvnoCode, 'mifiImei': goodsProvider.order.mifiImei});
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible (
                                  child: Text(
                                MyLocalizations.of(context).getString(buy_data),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: sp_14, color: color_theme),
                              )),
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
