import 'package:flutter/material.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';

class NetExceptionPage extends StatelessWidget {
  final Function refresh;

  NetExceptionPage(this.refresh);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("异常提醒"),
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Image(
                  image: new AssetImage('images/net_exception.png',),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 64.0),
                  child: Text("网络异常，请刷新重试",
                    style: TextStyle(fontSize: sp_16, color: color_bg_333333),
                  )
              ),
              Padding(
                padding: EdgeInsets.only(top: 32.0),
                child: Container(
                  height: 44.0,
                  width: 150.0,
                  child: OutlineButton(
                    splashColor: Colors.transparent,
                    highlightedBorderColor: Colors.transparent,
                    onPressed: () {
                      if (refresh != null) {
                        refresh();
                      }
                    },
                    child: Text("刷新",
                      style: TextStyle(fontSize: sp_16, color: color_bg_333333),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}