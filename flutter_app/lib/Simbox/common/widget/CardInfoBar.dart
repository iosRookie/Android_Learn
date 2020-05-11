import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/Simbox/res/colors.dart';

typedef ImportContacts = void Function();

class CardInfoBar extends StatefulWidget {
  final ImportContacts importContacts;
  CardInfoBar({this.importContacts});

  @override
  State<StatefulWidget> createState() => _CardInfoBarState();
}

class _CardInfoBarState extends State<CardInfoBar> {
  @override
  Widget build(BuildContext context) {
//    debugPaintSizeEnabled = true;
    return Container(
      color: SColors.theme_color,
      child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 15.0)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("魏斌的电信（7270）", style: TextStyle(color: Colors.white, fontSize: 15), textAlign: TextAlign.left),
                Text("864055040003435（卡槽1）", style: TextStyle(color: Colors.white, fontSize: 12), textAlign: TextAlign.left)
              ],
            ),
          ),
          widget.importContacts != null ? IconButton(icon: Icon(Icons.file_download, color: Colors.white),
              onPressed: () {
                widget.importContacts();
              }) : Container(),
          Padding(padding: EdgeInsets.only(right: 15.0)),
        ],
      )
    );
  }
}