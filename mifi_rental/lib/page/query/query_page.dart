import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/entity/order.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/query/query_provider.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';

class QueryPage extends BasePage {
  final Order order;
  QueryPage(this.order);

  @override
  Widget doBuild(BuildContext context, Widget scaffold) {
    return scaffold;
  }

  @override
  List<BaseProvider> setProviders() {
    return [QueryProvider(this.order)];
  }

  @override
  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        MyLocalizations.of(context).getString(tips),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
    );
  }

  @override
  Widget setBody(BuildContext context) {
    return WillPopScope(
      child: _body(context),
      onWillPop: () {
        return Future.value(false);
      },
    );
  }

  Widget _body(BuildContext context) {
    return Center( child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color_theme),
        ),
        Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text(
              MyLocalizations.of(context).getString(please_wait),
              style: TextStyle(fontSize: sp_16, color: color_text_333333),
            )),
      ],
    ));
    // 测试代码
//    return ListView.builder(
//        itemCount: 4,
//        itemBuilder: (context, index) {
//          Widget title = Text('弹出成功');
//          switch(index) {
//            case 1: title = Text('弹出失败');
//            break;
//            case 2: title = Text('租赁失败');
//            break;
//            case 3: title = Text('支付失败');
//            break;
//            default:
//              break;
//          }
//          return ListTile(title: title, onTap:() {
//            switch(index) {
//              case 0: {
//                Navigator.of(context).pushReplacementNamed(SUCCESS);
//              }
//              break;
//              case 1:{
//                showDialog(
//                    barrierDismissible: false,
//                    context: context,
//                    builder: (context) {
//                      return AlertDialog(
//                        title: Text(MyLocalizations.of(context).getString(popup_timeout_title)),
//                        content: Text(MyLocalizations.of(context).getString(popup_timeout_message)),
//                        actions: <Widget>[
//                          FlatButton(
//                            child: Text(MyLocalizations.of(context).getString(confirm)),
//                            onPressed: () {
//                              Navigator.of(context).pushNamedAndRemoveUntil(DEVICE, (Route<dynamic> route) => false);
//                            },
//                          ),
//                        ],
//                      );
//                    }
//                );
//              }
//              break;
//              case 2:{
//                Navigator.of(context).pushReplacementNamed(RENT_FAIL);
//              }
//              break;
//              case 3:  {
//                Navigator.of(context).pushReplacementNamed(PAY_FAIL, arguments: '');
//              }
//              break;
//              default:
//                break;
//            }
//          },);
//        });
  }
}
