import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Simbox/common/mvp/base_page_state.dart';
import 'package:flutter_app/Simbox/common/widget/list_index_view.dart';
import 'package:flutter_app/Simbox/login/model/country_code_model.dart';
import 'package:flutter_app/Simbox/login/presenter/country_code_select_presenter.dart';
import 'package:flutter_app/Simbox/res/colors.dart';
import 'package:flutter_app/Simbox/routes/fluro_navigator.dart';


const double ITEM_HEIGHT = 16;
const double SEPARATED_HEIGHT = 0.5;

class CountryCodeSelectPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CountryCodeSelectPageState();
}

class CountryCodeSelectPageState
    extends BasePageState<CountryCodeSelectPage, CountryCodeSelectPresenter> {
  List<String> _keys = [];
  List<dynamic> datas = [];
  ScrollController _scrollController = ScrollController();
  Map<String, int> _sectionCount = Map();
  String _indexTiltle;
  bool _showIndexTitle = false;

  @override
  CountryCodeSelectPresenter createPresenter() => CountryCodeSelectPresenter();

  @override
  void initState() {
    super.initState();
    presenter?.getCountryCodeList();
  }

  @override
  Widget build(BuildContext context) {
//    debugPaintSizeEnabled = true;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            '选择国家或地区',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: SColors.theme_color,
        ),
        body: Stack(
          children: _stackContent()
        ));
  }

  List<Widget> _stackContent() {
    List<Widget> widgets = List();
    widgets.add(_contentListView());
    widgets.add(_indexBar());
    if (_showIndexTitle) {
      widgets.add(_alertView());
    }
    return widgets;
  }

  void setListDatas(Map sections) {
    List<String> tempKeys = sections.keys.toList();
    tempKeys.sort((a, b) {
      return a.compareTo(b);
    });

    List<dynamic> datas = List();
    tempKeys.forEach((key) {
      datas.add(key);
      datas.addAll(sections[key] as List);

      _sectionCount[key] = (sections[key] as List).length;
    });

    setState(() {
      this.datas = datas;
      _keys = tempKeys;
    });
  }

  void _selectedIndex(int index) {
    NavigatorUtils.popResult(context, this.datas[index].toJson());
  }

  Widget _contentListView() {
    return Container(
      padding: EdgeInsets.only(right: 0),
      child: ListView.separated(
          controller: _scrollController,
          itemBuilder: ((context, index) {
            if (datas[index] is String) {
              return Container(
                padding: EdgeInsets.only(left: 15.0),
                alignment: Alignment.centerLeft,
                color: SColors.divider_color,
                  height: 30,
                  child: Text(datas[index],
                      style: TextStyle(color: Color(0xff666666))),
              );
            } else if (datas[index] is CountryCodeModel) {
              return SizedBox(
                height: 50,
                child: ListTile(
                  title: Text(datas[index].countryName == null
                      ? "无数据" : datas[index].countryName),
                  trailing: Text(
                      datas[index].telprex == null ? "无数据" : datas[index].telprex),
                  onTap: (() {
                    _selectedIndex(index);
                  }),
                )
              );
            } else {
              return SizedBox(
                  height: 50,
                  child:ListTile(title: Text("")));
            }
          }),
          separatorBuilder: (context, index) {
            return Container(height: SEPARATED_HEIGHT, color: SColors.divider_color);
          },
          itemCount: datas.length)
    );
  }

  Widget _indexBar() {
    return Align(
        alignment: Alignment.centerRight,
        child: ListIndexView(ITEM_HEIGHT, _keys, width: 30, indexSelected:(index, title, isTouchDown) {
          _onIndexBarTouch(index, title, isTouchDown);
        })
    );
  }

  void _onIndexBarTouch(int index, String title, bool show) {
    setState(() {
      _indexTiltle = title;
      _showIndexTitle = show;
      double dy = 0;
      for (int i=0; i<index; i++) {
        String key = _keys[i];
        int count = _sectionCount[key];
        dy += count * (50 + SEPARATED_HEIGHT) + (30 + SEPARATED_HEIGHT);
      }
      _scrollController.jumpTo(dy.toDouble().clamp(.0, _scrollController.position.maxScrollExtent));
    });
  }

  _alertView() {
    if (_showIndexTitle) {
      return Align(
        alignment: Alignment.center,
        child: Card(
          color: Colors.black54,
          child: Container(
            alignment: Alignment.center,
            width: 80.0,
            height: 80.0,
            child: Text('$_indexTiltle', style: TextStyle(fontSize: 32.0, color: Colors.white,),
            ),
          ),
        )
      );
    } else {
      return null;
    }
  }
}
