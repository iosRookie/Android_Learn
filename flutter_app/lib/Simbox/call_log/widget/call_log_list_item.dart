import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Simbox/res/colors.dart';

/// 渲染Item的实体类
class ItemEntity {
  String sectionTitle;
  bool isSection;
  String title;
  IconData iconData;

  ItemEntity(this.title, this.iconData, this.isSection, this.sectionTitle);
}

class CallLogListItem extends StatefulWidget {
  final ItemEntity itemEntity;

  CallLogListItem(this.itemEntity);

  @override
  State<StatefulWidget> createState() {
    return new _CallLogListItemState(itemEntity);
  }
}

class _CallLogListItemState extends State<CallLogListItem> {
  ItemEntity itemEntity;

  _CallLogListItemState(this.itemEntity);

  @override
  Widget build(BuildContext context) {
    return _getItemView(itemEntity);
  }

  Widget _getItemView(ItemEntity entity) {
    if (itemEntity.isSection) {
      return new Container(
          padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          child: _getSection(itemEntity));
    } else {
      return new Container(
          color: Colors.transparent,
          padding: EdgeInsets.fromLTRB(15.0, 0, 15.0, 0),
          child: _getItem(itemEntity));
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
        ));
  }

  Widget _getItem(ItemEntity entity) {
    return new Container(
//      height: 118,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15.0, top: 20, right: 15.0),
            child: Row(
              children: <Widget>[
                Text(
                  "阿浩",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700),
                ),
                Padding(padding: EdgeInsets.only(left: 5.0)),
                Expanded(
                  child: Text(
                    "助手接听中...",
                    style:
                        TextStyle(fontSize: 12.0, color: SColors.theme_color),
                  ),
                ),
                Text(
                  "09:20",
                  style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
                ),
              ],
            ),
          ),
          Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15.0, top: 10.0, right: 15.0),
              child: Text(
                "广东深圳 联通",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
              )),
          Padding(padding: EdgeInsets.only(top: 15.0)),
          Container(height: 0.5, color: SColors.divider_color),
          Row(
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                      onTap: () {},
                      child: Container(
                          alignment: Alignment.center,
                          height: 42.5,
                          child: Text("删除",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0, color: Color(0xff333333)
                              )
                          )
                      )
                  )
              ),
              Container(width: 0.5, height: 42.5, color: SColors.divider_color),
              Expanded(
                child: GestureDetector(
                    onTap: () {},
                    child: Container(
                        alignment: Alignment.center,
                        height: 42.5,
                        child: Text("查看通话记录",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xff333333)
                            )
                        )
                    )
                ),
              ),
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
