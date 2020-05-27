import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/page/query/query_provider.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';

class QueryPage extends BasePage {
  @override
  Widget doBuild(BuildContext context, Widget scaffold) {
    return scaffold;
  }

  @override
  List<BaseProvider> setProviders() {
    return [QueryProvider()];
  }

  @override
  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      title: Text(
        '提示',
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget setBody(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_theme),
        ),
        Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              '正在弹出设备，请稍后...',
              style: TextStyle(fontSize: sp_16, color: color_text_333333),
            )),
      ],
    ));
  }
}
