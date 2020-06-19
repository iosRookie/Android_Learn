import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/res/colors.dart';

class RentSuc extends StatelessWidget {
  int _index;

  RentSuc(this._index) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: color_text_333333,
          ),
          onPressed: () {
//            FlutterBoost.singleton.closeCurrent();
              Navigator.of(context).pop();
          },
        ),
        title: Text(
          '租赁成功',
          style: TextStyle(
            color: color_text_333333,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          repSection(),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text.rich(
                  TextSpan(children: <TextSpan>[
                    TextSpan(text: '设备已在', style: TextStyle(fontSize: 20)),
                    TextSpan(
                        text: ' $_index ',
                        style: TextStyle(fontSize: 30, color: color_theme)),
                    TextSpan(text: '号仓位弹出！', style: TextStyle(fontSize: 20)),
                  ]),
                ),
                Text(
                  '请拿好您的设备，开机即可享受WIFI服务！',
                  style: TextStyle(color: color_text_666666),
                ),
                FlatButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  onPressed: () {},
                  child: Text(
                    '查看设备信息',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: color_theme,
                  shape: const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                  textColor: color_bg_FFFFFF,
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Text(
                    '获取设备后请在5分钟内进行检查，如果发现有问题请点击\“故障申告\”进行反馈，反馈完毕后请将设备插回机器空置仓位，此期间不计费。',
                    style: TextStyle(color: color_text_666666),
                  ),
                ),
                OutlineButton(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 32),
                  onPressed: () {},
                  child: Text(
                    '故障申告',
                    style: TextStyle(fontSize: 18),
                  ),
                  textColor: color_theme,
                  borderSide: BorderSide(color: color_theme),
                  shape: const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget repSection() {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: color_theme,
      ),
      child: Container(
        margin: const EdgeInsets.all(28),
        decoration: BoxDecoration(
          color: color_bg_main,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _assembleRep(),
          ),
        ),
      ),
    );
  }

  List<Widget> _assembleRep() {
    var widgets = <Widget>[];
    for (int i = 1; i < 11; i++) {
      widgets.add(_generateRep(_index == i, i));
    }
    return widgets;
  }

  Widget _generateRep(bool isActive, int i) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.brightness_1,
          color: isActive ? color_theme : color_bg_main,
          size: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: isActive ? color_theme : color_text_999999,
          ),
          width: 18,
          height: 60,
        ),
        Text(
          '$i',
          style: TextStyle(
            color: isActive ? color_theme : color_text_999999,
          ),
        )
      ],
    );
  }
}
