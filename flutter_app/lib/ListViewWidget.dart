import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/ListViewItem.dart';

class ListViewWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ListViewWidgetState();
  }
}

class _ListViewWidgetState extends State<ListViewWidget> {
  List<ItemEntity> entityList = [];
  ScrollController _scrollController = new ScrollController();
  bool isLoadData = false;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        print("----------加载更多----------");
        _getMoreData();
      }
    });
    entityList.addAll(_getTestDatas());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ListView Learn"),
        ),
        body: Center(
            child: RefreshIndicator(
              displacement: 50,
              child: ListView.separated(
                itemCount: entityList.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index == entityList.length) {
                    return LoadMoreView();
                  } else {
                    return ListViewItem(entityList[index]);
                  }
                },
                separatorBuilder: (BuildContext context, int index) {
                  return new Container(height: 20.0, color: Colors.transparent);
                },
                controller: _scrollController,
              ),
              onRefresh: _handleRefresh,
            )
        )
    );
  }

  List<ItemEntity> _getTestDatas() {
    List<ItemEntity> datas = List<ItemEntity>();
    for (int section=0; section < Random().nextInt(10) + 1; section++) {
      datas.add(ItemEntity(null, null, true, "Section $section"));
      for (int index=0; index < Random().nextInt(10); index++) {
        datas.add(ItemEntity("Item $index", Icons.favorite_border, false, null));
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
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Learn"),
      ),
      body:Container(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Center(
            child: Row(
              children: <Widget>[
                new Container(
                  width: 20,
                  height: 20,
                  child:new CircularProgressIndicator(strokeWidth: 2,),
                ),
                Padding(padding: EdgeInsets.all(10),),
                Text("加载中...")
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ),
      ),
    );
  }
}