import 'package:flutter/material.dart';

class HomeListView extends StatelessWidget {
  final List<String> _items;

  HomeListView(this._items);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView Learn"),
      ),
      body: Center(
        child: ListView.separated(
            itemBuilder: (context, index) {
              return _getItem(context, index);
            },
            separatorBuilder: (context, index) {
              return new Container(
                height: 1.0,
                color: Colors.grey,
                margin: EdgeInsets.only(left: 20.0),
              );
            },
            itemCount: _items.length),
      ),
    );
  }

  Widget _getItem(BuildContext context, int index) {
    return ListTile(
        contentPadding: EdgeInsets.only(left: 20.0),
        title: Text("${_items[index]}"),
        onTap: () => {
          Navigator.pushNamed(context, "/listViewLearn")
        }
    );
  }

  void _tapListItem(){}
//  (BuildContext context, int index) {
//    if (_items[index] == "ListViewLearn") {
////      Navigator.pushNamed(context, "listViewLearn");
//      Navigator.push(context, MaterialPageRoute(builder: (context) {
//        return ListViewWidget();
//      }));
//    }
//  }

}