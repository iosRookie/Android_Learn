import 'dart:ui';
import 'package:flutter/material.dart';

class CustomKeyBoardView extends StatelessWidget {
  const CustomKeyBoardView();

  static const int _rowCount = 3;
  static const int _columnCount = 4;
  static const double _itemAspectRatio = 2.0;
  static const double _bottomToolsViewHeight = 64;
  double _itemWidth() => (MediaQueryData.fromWindow(window).size.width - (_rowCount - 1) * 0.5)/_rowCount;
  double _itemHeight() => _itemWidth()/_itemAspectRatio;
  double _keyBoardHeight() => _itemHeight() * _columnCount + (_columnCount - 1) * 0.5;

  double keyBoardHeight() => _keyBoardHeight() + _bottomToolsViewHeight;

  @override
  Widget build(BuildContext context) {
    return _keyboardView();
  }

  Widget _keyboardView() {
    return Container(
        height: _keyBoardHeight() + _bottomToolsViewHeight + 0.5,
        width: MediaQueryData.fromWindow(window).size.width,
        color: Color(0xff999999),
        child: Column(
            children: [
              Container (
                color: Colors.transparent,
                height: _keyBoardHeight() + 0.5,
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 0.5,
                        mainAxisSpacing: 0.5,
                        crossAxisCount: _rowCount,
                        childAspectRatio: _itemAspectRatio
                    ),
                    itemCount: _rowCount * _columnCount,
                    itemBuilder: (context, index) {
                      return _getItemContainer(index);
                    }
                ),
              ),
              Container(
                color: Colors.white,
                height: _bottomToolsViewHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.settings),

                    Icon(Icons.settings),
                  ],
                ),
              )
            ]
        )
    );
  }

  Widget _getItemContainer(int index) {
    return GestureDetector(
      child: Container(
        height: _itemHeight(),
        width: _itemWidth(),
        color: Colors.white,
        alignment: Alignment.center,
        child: Text(index.toString(), style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      onTap: () {
        _onTapKeyBoard(index);
      },
    );
  }

  void _onTapKeyBoard(int index) {
    print("click keyboard index = " + index.toString());
  }
}