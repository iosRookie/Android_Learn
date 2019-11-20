import 'dart:ui';
import 'package:flutter/material.dart';

const double CardAppBarHeight = kToolbarHeight;

class CardAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  State<StatefulWidget> createState() {
    return _CardAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(CardAppBarHeight + MediaQueryData.fromWindow(window).padding.top);
}

class _CardAppBarState extends State<CardAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: CardAppBarHeight + MediaQueryData.fromWindow(window).padding.top,
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          top: true,
          child: Container(
              height: CardAppBarHeight,
              width: MediaQueryData.fromWindow(window).size.width,
              child: Row(
                children: <Widget>[
                  _cardList(),
                  _rightAction()
                ],
              )
          ),
        )
    );
  }

  Widget _cardList() {
    return Container(
        width: MediaQueryData.fromWindow(window).size.width * 2.0/3.0,
        padding: EdgeInsets.only(left: 15.0, right: 30.0),
        color: Colors.transparent,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return Container(
              width: 10.0,
            );
          },
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  _clickCardItem(index);
                },
                child: Icon(Icons.card_travel, size: 30,)
            );
          },
          itemCount: 8,
        )
    );
  }

  Widget _rightAction() {
    return Container(
      alignment: Alignment.centerRight,
      width: MediaQueryData.fromWindow(window).size.width * 1.0/3.0,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _onTapSearch();
            },
            child: Icon(Icons.search, size: 20, color: Colors.white,),
          ),
          Padding(padding: EdgeInsets.only(left: 10.0),),
          GestureDetector(
            onTap: () {
              _switchCardState();
            },
            child:Icon(Icons.swap_horiz, size: 20, color: Colors.white,),
          ),
          Padding(padding: EdgeInsets.only(left: 20.0),),
        ],
      ),
    );
  }

  void _clickCardItem(int index) {

  }

  void _onTapSearch() {

  }

  void _switchCardState() {

  }
}

/// https://www.jb51.net/article/157680.htm