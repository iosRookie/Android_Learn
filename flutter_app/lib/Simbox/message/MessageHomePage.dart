import 'package:flutter/material.dart';

class MessageHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessageHomePageState();
  }
}

class MessageHomePageState extends State<MessageHomePage> with AutomaticKeepAliveClientMixin<MessageHomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('短信'),
      ),
      body: Center(
        child: Text('短信'),
      ),
    );
  }
}