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
  @override
  void setState(fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
//      child: new ListView(
//        children: getItems(),
//      ),
        child: ListView.separated(
            itemCount: 20,
            itemBuilder: (BuildContext context, int i) {
              return new ListTile(title: new Text("list $i"));
            },
          separatorBuilder: (BuildContext context, int i) {
            return new Container(height: 10.0, color: Colors.grey);
          },
        ),
    );
  }

  List<Widget> getItems() {
    List<Widget> list = new List();
    for(int i = 0; i < 20; i++){
      list.add(
        new Column(
          children: <Widget>[
            new ListTile(title: new Text("list $i"),),
          ],
        )
      );
    }
    return list;
  }

}