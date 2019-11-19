import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/page/common/CardAppBar.dart';

class CallLogHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CallLogHomePageState();
  }
}

class CallLogHomePageState extends State<CallLogHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CardAppBar(),
      body: Center(
        child: Text('通话记录'),
      ),
    );
  }
}