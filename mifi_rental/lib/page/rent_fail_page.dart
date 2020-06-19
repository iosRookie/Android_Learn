import 'package:flutter/material.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';

class RentFailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _Body(),
      appBar: AppBar(
        backgroundColor: color_bg_FFFFFF,
        title: Text(
          MyLocalizations.of(context).getString(rent_fail),
          style: TextStyle(fontSize: sp_title)
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
//            BoostContainerSettings settings =
//                BoostContainer.of(context).settings;
//            FlutterBoost.singleton.close(settings.uniqueId);
              Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: color_bg_333333,
          )
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Image.asset('images/no_rent_device.png'),
            padding: EdgeInsets.fromLTRB(0, 60.0, 0, 20.0),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 16),
            child: Text(
              MyLocalizations.of(context).getString(pay_fail),
              style: TextStyle(color: color_text_E4393C, fontSize: sp_20),
            ),
          ),
          Text(
            MyLocalizations.of(context).getString(pay_fail_tip),
            style: TextStyle(color: color_text_333333, fontSize: sp_14),
          ),
          Container(
            padding: EdgeInsets.only(top: 36),
            child: OutlineButton(
              padding: EdgeInsets.fromLTRB(43, 14, 43, 14),
              onPressed: () {},
              child: Text(
                MyLocalizations.of(context).getString(repay),
                style: TextStyle(fontSize: sp_16)
              ),
              textColor: color_text_5099CC,
              borderSide: BorderSide(color: color_text_5099CC,width: 0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          )
        ],
      ),
    );
  }
}


