import 'package:core_log/core_log.dart';
import 'package:flutter/material.dart';
import 'package:mifi_rental/common/loading_page_util.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/dialog/loading.dart';
import 'package:mifi_rental/entity/flow_packages.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/flow_package_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';

class FlowPackagePage extends StatefulWidget {
  final Map maps;
  final List<DataList> dataList = List<DataList>();

  FlowPackagePage(this.maps);

  @override
  State<StatefulWidget> createState() => FlowPackagePageState();
}

class FlowPackagePageState extends State<FlowPackagePage> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  bool _loading = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _requestData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return LoadingPageUtil(
        color: Colors.black,
        opacity: 0.5,
        progressIndicator: LoadingDialog(text: 'loading'),
        loading: _loading,
        child: Scaffold(
            body: _body(),
            appBar: AppBar(
              backgroundColor: color_bg_main,
              elevation: 0,
              title: Text(
                MyLocalizations.of(context).getString(flow_package),
                style: TextStyle(fontSize: sp_title),
              ),
              centerTitle: true,
              leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: color_bg_333333,
                  )
              ),
            ),
            floatingActionButton: SizedBox(
                width: MediaQuery.of(context).size.width - 32.0,
                height: 44,
                child: RaisedButton(
                    elevation: 0.0,
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    onPressed: () {
                      Navigator.of(context).pushNamed(FLOW_PACKAGE_PAY, arguments: {
                        'data': widget.dataList[_selectedIndex],
                        'imei': widget.maps["mifiImei"],
                        'mvnoCode': widget.maps["mvnoCode"]});
                    },
                    color: color_theme,
                    child: Text(
                      "购买",
                      style: TextStyle(
                          fontSize: sp_16, color: color_text_FFFFFF),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    )
                )
            )
        )
    );
  }

  Widget _body() {
    return Container(
        color: color_bg_FFFFFF,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                MyLocalizations.of(context).getString(choose_package),
                style: TextStyle(color: color_text_333333, fontSize: sp_16, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: EdgeInsets.only(top: 12.0),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, //每行三列
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 1.5 //显示区域宽高相等
                    ),
                    itemCount: widget.dataList.length,
                    itemBuilder: (context, index) {
                      return _flowPackageView(widget.dataList[index], index);
                    }
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text(
                    MyLocalizations.of(context).getString(notice_for_use),
                    style: TextStyle(color: color_text_333333, fontSize: sp_16, fontWeight: FontWeight.bold),
                  )
              ),
              Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Container(
                    child: Text(
                      widget.dataList.length > 0 ? widget.dataList[_selectedIndex].attrMap.pkDesc : "",
                      style: TextStyle(color: color_text_999999, fontSize: sp_14),
                    ),
                  )
              )
            ],
          ),
        )
    );
  }

  Widget _flowPackageView(DataList dataList, int index) {
      return Container (
        alignment: Alignment.center,
//        width: (MediaQuery.of(context).size.width - 16.0*2 - 10.0*2)/3.0,
//        height: (MediaQuery.of(context).size.width - 16.0*2 - 10.0*2)/(3.0*1.5),
        child: GestureDetector(
          onTap: () {
            setState(() {
              ULog.i("tap $index");
              _selectedIndex = index;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                  dataList.flowByte.toString() + "M",
                  style: TextStyle(
                      fontSize: sp_16,
                      color: _selectedIndex == index ? Colors.white : color_text_333333)
              ),
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                    '售价: ' + dataList.currencyType.toString() + " " + dataList.goodsPrice.toString(),
                    style: TextStyle(
                        fontSize: sp_12,
                        color: _selectedIndex == index ? Colors.white : color_text_999999)
                ),
              )
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: _selectedIndex == index ?  color_theme : color_bg_F5F5F5,
          border: Border.all(
            color: _selectedIndex == index ?  color_theme : color_text_E0E0E0,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
      );
  }
  
  _requestData() {
    FlowPackageRepository.queryOfferList(widget.maps["mvnoCode"], (data) {
      setState(() {
        _loading = false;
        if (widget.dataList.length < 9) {
          widget.dataList.addAll(data.dataList);
        }
      });
    }, (error) {
      setState(() {
        _loading = false;
      });
    });
  }
}