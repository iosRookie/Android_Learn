import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 渲染Item的实体类
class ItemEntity {
  String sectionTitle;
  bool isSection;
  String title;
  IconData iconData;

  ItemEntity(this.title, this.iconData, this.isSection, this.sectionTitle);
}

class ListViewItem extends StatefulWidget {
  final ItemEntity itemEntity;
  ListViewItem(this.itemEntity);

  @override
  State<StatefulWidget> createState() {
    return new _ListViewItemState(itemEntity);
  }
}

class _ListViewItemState extends State<ListViewItem> {
  ItemEntity itemEntity;

  _ListViewItemState(this.itemEntity);

  @override
  Widget build(BuildContext context) {
    return _getItemView(itemEntity);
  }

  Widget _getItemView(ItemEntity entity) {
    if (itemEntity.isSection) {
      return new Container(
          padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          child: _getSection(itemEntity)
      );
    } else {
      return new Container(
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          child: _getItem(itemEntity)
      );
    }
  }

  Widget _getSection(ItemEntity entity) {
    return new Container(
      height: 44.0,
      alignment: Alignment.bottomCenter,
      child: new Container(
        width: 120,
        height: 24,
        alignment: Alignment.center,
        child: new Text(
          entity.sectionTitle,
          style: new TextStyle(
              color: Colors.white,
              fontSize: 12,
          ),
          textAlign: TextAlign.center,
        ),
        decoration: new BoxDecoration(
          color: Color(0xFFC0C0C0),
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
        ),
      )
    );
  }

  Widget _getItem(ItemEntity entity) {
    return new Container(
      height: 118.0,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("阿浩"),
              Text("助手接听中..."),
              Text("09:20"),
            ],
          ),
          Text("广东深圳 联通"),
          Row(
            children: <Widget>[
              Text("删除"),
              Text("查看通话记录")
            ],
          )
        ],
      ),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(4.0)),
      ),
    );
  }
}

///https://www.jianshu.com/p/30e1550e1d6b