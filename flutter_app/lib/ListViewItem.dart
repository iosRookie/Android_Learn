import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListViewItem extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _ListViewItemState();
  }
}

class _ListViewItemState extends State<ListViewItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Text("123",
      style: new TextStyle(
        color: Colors.red,
        fontSize: 14.0,
      ),
    );
  }

}