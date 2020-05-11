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
  String _indexTitle;
  bool _showIndexTitle = false;

  @override
  CountryCodeSelectPresenter createPresenter() => CountryCodeSelectPresenter();

  @override
  void initState() {
    super.initState();
    presenter?.getCountryCodeList();
  }

  @override
  disMissProgressCallBack(Function func) {

    return super.disMissProgressCallBack(func);
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
      child: ListView.builder(
          controller: _scrollController,
          itemBuilder: ((context, index) {
            bool showDivider = true;
            if (datas[index] is CountryCodeModel) {
              if (index + 1 < datas.length) {
                if(datas[index + 1] is CountryCodeModel) showDivider = true;
                else showDivider = false;
              }
              return _getItemView(index, showDivider);
            } else {
              return _getSectionView(index);
            }
          }),
//          Container(height: SEPARATED_HEIGHT, color: SColors.divider_color)
          itemCount: datas.length)
    );
  }

  Widget _getSectionView(int index) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      alignment: Alignment.centerLeft,
      color: SColors.divider_color,
      height: 30,
      child: Text(datas[index], style: TextStyle(color: Color(0xff666666)))
    );
  }

  Widget _getItemView(int index, bool showDivider) {
    return Container(
        height: 50,
        child: Column(
            children: [
              Expanded (
                  child: GestureDetector(
                    child: Row(
                        children: <Widget>[
                          Padding(padding:  EdgeInsets.only(left: 15.0)),
                          Expanded (
                              child:Text(datas[index].countryName == null ? "无数据" : datas[index].countryName)),
                          Text(datas[index].telprex == null ? "无数据" : datas[index].telprex),
                          Padding(padding:  EdgeInsets.only(right: 40.0)),
                        ]
                    ),
                    onTap: (() {
                      _selectedIndex(index);
                    }),
                  )
              ),
              showDivider ? Container(margin: EdgeInsets.only(left: 15.0), height: SEPARATED_HEIGHT, color: SColors.divider_color) : Container()
            ]
        )
    );
  }

  Widget _indexBar() {
    return Align(
        alignment: Alignment.centerRight,
        child: ListIndexView(ITEM_HEIGHT, _keys, width: 30, defaultIndex: 0, indexSelected:(index, title, isTouchDown) {
          _onIndexBarTouch(index, title, isTouchDown);
        })
    );
  }

  void _onIndexBarTouch(int index, String title, bool show) {
    setState(() {
      _indexTitle = title;
      _showIndexTitle = show;
      double dy = 0;
      for (int i=0; i<index; i++) {
        String key = _keys[i];
        int count = _sectionCount[key];
        dy += count * 50 + 30;
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
            child: Text('$_indexTitle', style: TextStyle(fontSize: 32.0, color: Colors.white,),
            ),
          ),
        )
      );
    } else {
      return null;
    }
  }
}
