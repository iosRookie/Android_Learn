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
  @override
  void initState() {
    super.initState();
    for (int i = 0; i<10; i++) {
      entityList.add(ItemEntity("Item $i", Icons.accessibility));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: RefreshIndicator(
        displacement: 50,
        color: Colors.redAccent,
        backgroundColor: Colors.blue,
        child: ListView.separated(
          itemCount: entityList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListViewItem(entityList[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return new Container(height: 10.0, color: Colors.grey);
         },
        ),
        onRefresh: _handleRefresh,
      )
    );
  }

  Future<Null> _handleRefresh() async {
    print("-------------开始刷新---------");
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        entityList.clear();
        entityList = List.generate(10, (index) => new ItemEntity("下拉刷新--item $index", Icons.accessibility));
      });
    });
  }
}
