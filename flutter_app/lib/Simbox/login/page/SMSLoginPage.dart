import 'package:flutter/material.dart';

class SMSLoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SMSLoginPageState();
}

class _SMSLoginPageState extends State<SMSLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("短信登陆"),
      ),
      body: Center(
        child: Text('短信登陆'),
      ),
    );
  }
}
