import 'package:flutter/material.dart';

class PageNotFount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("不存在界面"),
      ),
      body: Center(
        child: Text('router 错误'),
      ),
    );
  }
}