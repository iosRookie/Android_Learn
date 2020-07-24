import 'package:flutter/material.dart';
import 'package:mifi_rental/common/loading_page_util.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/pay/order_provider.dart';
import 'package:mifi_rental/page/pay/rental_agreement_provider.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:provider/provider.dart';

class PayPage extends StatefulWidget {
  final String _sn;
  PayPage(this._sn);

  @override
  State<StatefulWidget> createState() {
    return PayPageState();
  }
}

class PayPageState extends State<PayPage> with AutomaticKeepAliveClientMixin {
  OrderProvider _orderProvider;
  RentalAgreementProvider _rentalProvider;
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _orderProvider = OrderProvider();
    _orderProvider.context = context;
    _orderProvider.globalKey = GlobalKey<ScaffoldState>();

    _rentalProvider = RentalAgreementProvider();
    _rentalProvider.context = context;

    _rentalProvider.getAgreement(widget._sn,
        success: () {
          setState(() {
            _loading = false;
          });
        },
        failure: () {
          setState(() {
            _loading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingPageUtil(
        loading: _loading,
        child: SafeArea(
            top: false,
            child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (_) => _rentalProvider),
                  Provider(create: (_) => _orderProvider)],
                child: Scaffold(
                  key: _orderProvider.globalKey,
                  appBar: setAppbar(context),
                  body: setBody(context),
                ))
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
          onTap: () { Navigator.of(context).pop(); },
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
              physics: BouncingScrollPhysics(),
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
          _Pay(widget._sn),
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
    RentalAgreementProvider provider =
        Provider.of<RentalAgreementProvider>(context);
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
                  provider.deposit ?? '',
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

class _RuleState extends State<_Rule> with AutomaticKeepAliveClientMixin{
  bool _isExpand = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
    OrderProvider orderProvider = Provider.of<OrderProvider>(context);
    RentalAgreementProvider rentalAgreementProvider =
        Provider.of<RentalAgreementProvider>(context);
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
                        rentalAgreementProvider.deposit ?? '',
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
                orderProvider.createOrder(sn);
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
