import 'package:flutter/material.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';

class FlowPackagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: _Body(),
      appBar: AppBar(
        backgroundColor: color_bg_FFFFFF,
        title: Text(
          MyLocalizations.of(context).getString(flow_package),
          style: TextStyle(fontSize: sp_title),
        ),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
//            BoostContainerSettings settings =
//                BoostContainer.of(context).settings;
//            FlutterBoost.singleton.close(settings.uniqueId);
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
      color: color_bg_FFFFFF,
      child: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 0, 12),
            child: Text(
              MyLocalizations.of(context).getString(choose_package),
              style: TextStyle(color: color_text_333333, fontSize: sp_16, fontWeight: FontWeight.bold),
            ),
          ),
          _FlowList(),
          Padding(
              padding: EdgeInsets.only(left: 16),
              child: Text(
                MyLocalizations.of(context).getString(notice_for_use),
                style: TextStyle(color: color_text_333333, fontSize: sp_16, fontWeight: FontWeight.bold),
              )
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Text(
              '加油包使用规则加油包使用规则加油包使用规则加油包使用规则加油包使用规则',
              style: TextStyle(color: color_text_999999, fontSize: sp_14),
            ),
          )
        ],
      )
    );
  }
}

class _FlowList extends StatefulWidget {

  _FlowList({Key key}) : super(key: key);

  @override
  __FlowListState createState() => __FlowListState();
  
}

class __FlowListState extends State<_FlowList> {
  int cur_index;
  void chooseFlow(index) {
    setState(() {
      cur_index = index;
    });
  }
  List flowData = [
    {
      'flowSize': '500M',
      'price': '\$2.5',
    },
    {
      'flowSize': '1G',
      'price': '\$5',
    },
    {
      'flowSize': '2G',
      'price': '\$9.5',
    },
    {
      'flowSize': '5G',
      'price': '\$15',
    },
    {
      'flowSize': '10G',
      'price': '\$28',
    },
    {
      'flowSize': '20G',
      'price': '\$60',
    },
  ];

  List<Widget> _getListData(context) {
    List<Widget> flowList = new List();
    for(var i = 0; i < flowData.length; i++) {
      flowList.add(GestureDetector(
        onTap:() {
          chooseFlow(i);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Column(
            children: <Widget>[
              Text(
                flowData[i]['flowSize'], 
                style: TextStyle(fontSize: sp_16, color: cur_index == i ? color_text_FFFFFF : color_text_333333)
              ),
              Padding(
                padding: EdgeInsets.only(top: 5),
                child: Text(
                  '售价: ' + flowData[i]['price'],
                  style: TextStyle(fontSize: sp_12, color: cur_index == i ? color_text_FFFFFF : color_text_999999)
                ), 
              )
            ]
          ),
          decoration: BoxDecoration(
            color: cur_index == i ? color_bg_5099CC : color_bg_F5F5F5,
            border: Border.all(
              color: color_text_E0E0E0,
              width: 0.5,
            ),
            borderRadius: BorderRadius.all(Radius.circular(4))
          ),
        ),
      ));
    }
    return flowList;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GridView.count(
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0, 
      padding: EdgeInsets.fromLTRB(16,0,16,24),
      crossAxisCount: 3,
      childAspectRatio: 1.7,
      shrinkWrap: true,
      children: _getListData(context),
      
    );
  }

}