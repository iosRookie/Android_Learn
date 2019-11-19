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
      color: Colors.red,
      child: SafeArea(
        top: true,
        child: Text('123'),
      ),
    );
  }
}

/// https://www.jb51.net/article/157680.htm