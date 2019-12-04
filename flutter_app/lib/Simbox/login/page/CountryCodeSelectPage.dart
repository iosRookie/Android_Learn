import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/common/mvp/BasePageState.dart';
import 'package:flutter_app/Simbox/login/model/CountryCodeModel.dart';
import 'package:flutter_app/Simbox/login/presenter/CountryCodeSelectPresenter.dart';
import 'package:flutter_app/Simbox/res/colors.dart';
import 'package:flutter_app/Simbox/routes/FluroNavigator.dart';

class CountryCodeSelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CountryCodeSelectPageState();
}

class CountryCodeSelectPageState extends BasePageState<CountryCodeSelectPage, CountryCodeSelectPresenter> {

  List<CountryCodeModel> datas = [];

  @override
  CountryCodeSelectPresenter createPresenter() => CountryCodeSelectPresenter();

  @override
  void initState() {
    super.initState();
    presenter?.getCountryCodeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('选择国家或地区', style: TextStyle(color: Colors.white),),
        backgroundColor: SColors.theme_color,
      ),
      body: ListView.separated(
          itemBuilder: ((context, index) {
            return ListTile(
              title: Text(datas[index].countryName == null ? "无数据" : datas[index].countryName),
              trailing: Text(datas[index].telprex == null ? "无数据" : datas[index].telprex),
              onTap: (() {
                _selectedIndex(index);
              }),
            );
          }),
          separatorBuilder: ((_, index) {
            return Container(height: 0.5, color: SColors.divider_color,);
          }),
          itemCount: datas.length)
    );
  }

  void setListDatas(List<CountryCodeModel> datas) {
    setState(() {
      this.datas = datas;
    });
  }

  void _selectedIndex(int index) {
    NavigatorUtils.popResult(context, this.datas[index].toJson());
  }

}