import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/call_log/widget/CallLogListItem.dart';
import 'package:flutter_app/Simbox/res/colors.dart';

class CallLogListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CallLogListViewState();
  }
}

class _CallLogListViewState extends State<CallLogListView> {
  List<ItemEntity> entityList = [];
  ScrollController _scrollController = new ScrollController();
  bool isLoadData = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("----------加载更多----------");
        _getMoreData();
      }
    });
    entityList.addAll(_getTestDatas());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: RefreshIndicator(
          color: SColors.theme_color,
          displacement: 30,
          child: ListView.separated(
            itemCount: entityList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index == entityList.length) {
                return LoadMoreView();
              } else {
                return CallLogListItem(entityList[index]);
              }
            },
            separatorBuilder: (BuildContext context, int index) {
              return new Container(height: 20.0, color: Colors.transparent);
            },
            controller: _scrollController,
          ),
          onRefresh: _handleRefresh,
        ));
  }

  List<ItemEntity> _getTestDatas() {
    List<ItemEntity> datas = List<ItemEntity>();
    for (int section = 0; section < Random().nextInt(10) + 1; section++) {
      datas.add(ItemEntity(null, null, true, "Section $section"));
      for (int index = 0; index < Random().nextInt(10) + 3; index++) {
        datas
            .add(ItemEntity("Item $index", Icons.favorite_border, false, null));
      }
    }
    return datas;
  }

  Future<Null> _handleRefresh() async {
    print("-------------开始刷新---------");
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        entityList.clear();
        entityList = _getTestDatas();
      });
    });
  }

  Future<Null> _getMoreData() async {
    await Future.delayed(Duration(seconds: 2), () {
      if (!isLoadData) {
        isLoadData = true;
        setState(() {
          isLoadData = false;
          List<ItemEntity> newList = _getTestDatas();
          entityList.addAll(newList);
        });
      }
    });
  }
}

class LoadMoreView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      color: Colors.transparent,
      child: Center(
          child: Row(
            children: <Widget>[
              new Container(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(SColors.theme_color),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0)),
              Text("加载中...")
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        )
    );
  }
}
