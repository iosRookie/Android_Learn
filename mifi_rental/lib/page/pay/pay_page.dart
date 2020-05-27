import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/pay/order_provider.dart';
import 'package:mifi_rental/page/pay/rental_agreement_provider.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:provider/provider.dart';

class PayPage extends BasePage {
  final String _sn;

  PayPage(this._sn);

  @override
  List<BaseProvider> setProviders() {
    return [OrderProvider(), RentalAgreementProvider()];
  }

  @override
  Widget doBuild(BuildContext context, Widget scaffold) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => getProvider<RentalAgreementProvider>()),
      Provider(create: (_) => getProvider<OrderProvider>()),
    ], child: scaffold);
  }

  @override
  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      title: Text(
        MyLocalizations.of(context).getString(pay),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            FlutterBoost.singleton.closeCurrent();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: color_bg_333333,
          )),
    );
  }

  @override
  Widget setBody(BuildContext context) {
    var p= getProvider<RentalAgreementProvider>();
    p.getAgreement(_sn);
    return Container(
      color: color_bg_FFFFFF,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Flexible(
            fit: FlexFit.tight,
            child: ListView(
              children: <Widget>[
                _Rule(),
                Container(
                  height: 10,
                  color: color_bg_main,
                ),
                _Deposit(),
                Container(
                  height: 10,
                  color: color_bg_main,
                ),
                _PayType(),
              ],
            ),
          ),
          Container(
            height: dp_line,
            color: color_line,
          ),
          _Pay(_sn),
        ],
      ),
    );
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

class _Deposit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(dp_frame, 15, dp_frame, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                MyLocalizations.of(context).getString(device_deposit),
                style: TextStyle(fontSize: sp_16, color: color_text_333333),
              ),
              Flexible(
                fit: FlexFit.tight,
                child: Text(
                  '\$150',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: sp_16, color: color_theme),
                ),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                MyLocalizations.of(context).getString(buckle_tip),
                style: TextStyle(fontSize: sp_12, color: color_text_999999),
              )),
        ],
      ),
    );
  }
}

class _Rule extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _RuleState();
  }
}

class _RuleState extends State<_Rule> {
  bool _isExpand = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RentalAgreementProvider provider =
        Provider.of<RentalAgreementProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(dp_frame, 15, dp_frame, 0),
          child: Text(
            MyLocalizations.of(context).getString(lease_tip),
            style: TextStyle(fontSize: sp_16, color: color_text_333333),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(dp_frame, 10, dp_frame, 0),
            child: Container(
                height: _isExpand == true ? null : 80,
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    Text(
                      provider.agreement ?? '',
                      style:
                          TextStyle(fontSize: sp_14, color: color_text_999999),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 30,
                          decoration: _isExpand == true
                              ? null
                              : BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                      color_bg_FFFFFF.withAlpha(100),
                                      color_bg_FFFFFF
                                    ])),
                        )),
                  ],
                ))),
        Center(
            child: FlatButton(
                onPressed: () {
                  setState(() {
                    _isExpand = !_isExpand;
                  });
                },
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      _isExpand == true
                          ? Icons.arrow_drop_down
                          : Icons.arrow_drop_up,
                      color: color_bg_333333,
                    ),
                    Text(
                      MyLocalizations.of(context).getString(expend_all),
                      style:
                          TextStyle(fontSize: sp_14, color: color_text_666666),
                    )
                  ],
                )))
      ],
    );
  }
}

class _Pay extends StatelessWidget {
  final String sn;

  _Pay(this.sn);

  @override
  Widget build(BuildContext context) {
    OrderProvider provider = Provider.of<OrderProvider>(context);
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
                        '\$150',
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
                provider.createOrder(sn);
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
}