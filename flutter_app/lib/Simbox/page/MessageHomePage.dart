import 'package:flutter/material.dart';

class MessageHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessageHomePageState();
  }
}

class MessageHomePageState extends State<MessageHomePage> {
  @override
  Widget build(BuildContext context) {
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