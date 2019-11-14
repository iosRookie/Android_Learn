import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 渲染Item的实体类
class ItemEntity {
  String title;
  IconData iconData;

  ItemEntity(this.title, this.iconData);
}

class ListViewItem extends StatefulWidget {
  ItemEntity itemEntity;
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
    return Container(
      height: 44.0,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(
              itemEntity.title,
            style: TextStyle(color: Colors.black87),
          ),
          Positioned(
            child: Icon(
              itemEntity.iconData,
              size: 30,
              color: Colors.blue
            ),
            left: 5.0,
          )
        ],
      ),
    );
  }
}

///https://www.jianshu.com/p/30e1550e1d6b