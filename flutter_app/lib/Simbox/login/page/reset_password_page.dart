import 'package:flutter/material.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('重设密码'),
      ),
      body: Center(
        child: Text('重设密码'),
      ),
    );
  }
}