import 'dart:ui';
import 'package:flutter/material.dart';

class CustomKeyBoardView extends StatefulWidget {
  Function hiddenKeyBoard;
  String parent;
  CustomKeyBoardView(this.hiddenKeyBoard, this.parent);

  @override
  State<StatefulWidget> createState() {
    return _CustomKeyBoardViewState();
  }
}

class _CustomKeyBoardViewState extends State<CustomKeyBoardView> {
  static const int _rowCount = 3;
  static const int _columnCount = 4;
  static const double _itemAspectRatio = 2.0;
  static const double _bottomToolsViewHeight = 64;

  String _inputText = "";

  double _itemWidth() =>
      (MediaQueryData.fromWindow(window).size.width - (_rowCount - 1) * 0.5) /
      _rowCount;

  double _itemHeight() => _itemWidth() / _itemAspectRatio;

  double _keyBoardHeight() =>
      _itemHeight() * _columnCount + (_columnCount - 1) * 0.5;

  double keyBoardHeight() => _keyBoardHeight() + _bottomToolsViewHeight * 2;
  List<KeyboardDisplayModel> _keyboardDisplayDatas = _keyboardDiaplayModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _keyboardView(context);
  }

  Widget _keyboardView(BuildContext context) {
    return Container(
        height: _keyBoardHeight() + _bottomToolsViewHeight * 2 + 1,
        width: MediaQueryData.fromWindow(window).size.width,
        color: Color(0xff999999),
        child: Column(children: [
          Container(
            color: Colors.white,
            height: _bottomToolsViewHeight,
            alignment: Alignment.center,
            child: TextField(
              cursorColor: Theme.of(context).primaryColor,
              cursorWidth: 1.0,
              focusNode: FocusNode(canRequestFocus: false),
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              autocorrect: false,
              style: TextStyle(
                fontSize: 30,
                color: Colors.black
              ),
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(Icons.backspace, color: Colors.grey,)
              ),
            ),
//            child: Text(
//              _inputText,
//              textAlign: TextAlign.center,
//              maxLines: 1,
//              style: TextStyle(fontSize: 30, color: Colors.black),
//            ),
          ),
          Container(
            color: Colors.transparent,
            height: 0.5,
          ),
          Container(
            color: Colors.transparent,
            height: _keyBoardHeight() + 0.5,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 0.5,
                    mainAxisSpacing: 0.5,
                    crossAxisCount: _rowCount,
                    childAspectRatio: _itemAspectRatio),
                itemCount: _rowCount * _columnCount,
                itemBuilder: (context, index) {
                  return _getItemContainer(index, _keyboardDisplayDatas[index]);
                }),
          ),
          Container(
            color: Colors.white,
            height: _bottomToolsViewHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    child: Icon(
                      Icons.settings,
                      color: Colors.black,
                    ),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onPressed: () {
                      _gotoSettingPage();
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                      alignment: AlignmentDirectional.center,
                      child: Container(
                        height: _bottomToolsViewHeight * 0.75,
                        width: MediaQueryData.fromWindow(window).size.width *
                            0.33333,
                        child: Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(
                                    _bottomToolsViewHeight * 0.75),
                                right: Radius.circular(
                                    _bottomToolsViewHeight * 0.75))),
                      )),
                ),
                Expanded(
                  child: FlatButton(
                    child: Icon(
                      Icons.keyboard_hide,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      _hiddenKeyboardView();
                    },
                  ),
                )
              ],
            ),
          )
        ]));
  }

  Widget _getItemContainer(int index, KeyboardDisplayModel model) {
    return GestureDetector(
      child: Container(
        height: _itemHeight(),
        width: _itemWidth(),
        color: Colors.white,
        alignment: Alignment.center,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text (model.title, style: TextStyle(color: Colors.black, fontSize: 22)),
            Text(model.subTitle, style: TextStyle(color: Colors.grey, fontSize: 12))
          ],
        )

      ),
      onTap: () {
        _onTapKeyBoard(index);
      },
    );
  }

  static List<KeyboardDisplayModel> _keyboardDiaplayModel() {
    List<KeyboardDisplayModel> datas = List();
    datas.add(KeyboardDisplayModel("1", ""));
    datas.add(KeyboardDisplayModel("2", "ABC"));
    datas.add(KeyboardDisplayModel("3", "DEF"));
    datas.add(KeyboardDisplayModel("4", "GHI"));
    datas.add(KeyboardDisplayModel("5", "JKL"));
    datas.add(KeyboardDisplayModel("6", "MNO"));
    datas.add(KeyboardDisplayModel("7", "PQRS"));
    datas.add(KeyboardDisplayModel("8", "TUV"));
    datas.add(KeyboardDisplayModel("9", "WXYZ"));
    datas.add(KeyboardDisplayModel("*", ""));
    datas.add(KeyboardDisplayModel("0", "+"));
    datas.add(KeyboardDisplayModel("#", ""));
    return datas;
  }

  void _onTapKeyBoard(int index) {
    print("click keyboard index = " + index.toString());
    setState(() {
      _inputText += _keyboardDisplayDatas[index].title;
    });
  }

  void _hiddenKeyboardView() {
    debugPrint("_hidenKeyboardView");
    widget.hiddenKeyBoard();
  }

  void _gotoSettingPage() {
    debugPrint("_gotoSettingPage");
  }
}

class KeyboardDisplayModel {
  String title, subTitle;
  KeyboardDisplayModel(this.title, this.subTitle);
}
