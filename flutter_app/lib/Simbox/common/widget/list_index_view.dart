import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/res/colors.dart';

typedef void IndexSelected(int index, String title, bool isTouchDown);

class ListIndexView extends StatefulWidget {
  final double itemHeight;
  final double width;
  final List<String> indexTitles;
  final IndexSelected indexSelected;

  ListIndexView(this.itemHeight, this.indexTitles, {
    this.indexSelected,
    this.width = 30
  });

  @override
  State<StatefulWidget> createState() => ListIndexViewState();
}


class ListIndexViewState extends State<ListIndexView> {

  int _currentSelected = 0;

  @override
  Widget build(BuildContext context) {
    int _currentSelectedIndex = 0;
    return Container(
      alignment: Alignment.center,
        width: 30,
        color: Colors.transparent,
        child: GestureDetector(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _indexItems()),
          onVerticalDragDown: (DragDownDetails details) {
            _currentSelectedIndex = (details.localPosition.dy / widget.itemHeight).ceil();
            _selectedItemIndex(_currentSelectedIndex, true, "onVerticalDragDown");
          },
          onVerticalDragUpdate: (DragUpdateDetails details) {
            _currentSelectedIndex = (details.localPosition.dy / widget.itemHeight).ceil();
            _selectedItemIndex(_currentSelectedIndex, true, "onVerticalDragUpdate");
          },
          onVerticalDragEnd: (DragEndDetails details) {
            _selectedItemIndex(_currentSelectedIndex, false, "onVerticalDragEnd");
          },
          onTapUp: (TapUpDetails details) {
            _currentSelectedIndex = (details.localPosition.dy / widget.itemHeight).ceil();
            _selectedItemIndex(_currentSelectedIndex, false, "onTapUp");
          },
        ));
  }

  List<Widget> _indexItems() {
    List<Widget> items = List();
    for (int index = 0; index < widget.indexTitles.length; index++) {
      items.add(
          SizedBox(
              width: 30,
              height: widget.itemHeight,
              child: Text(widget.indexTitles[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Color(0xff666666), fontSize: 13.0)
                ),
              )
      );
    }
    return items;
  }

  _selectedItemIndex(int index, bool isTouchDown, String methodName) {
    print("====>  index = $index  +++ $methodName");
    if (index >= 0 && index < widget.indexTitles.length) {
      if (_currentSelected == index && isTouchDown == true) return;
      _currentSelected = index;
      widget?.indexSelected(index, widget.indexTitles[index], isTouchDown);
    } else {
      widget?.indexSelected(_currentSelected, widget.indexTitles[_currentSelected], false);
    }
  }
}
