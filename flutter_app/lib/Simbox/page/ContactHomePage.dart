import 'package:flutter/material.dart';

class ContactHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactHomePageState();
  }
}

class ContactHomePageState extends State<ContactHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('联系人'),
      ),
      body: Center(
        child: Text('联系人'),
      ),
    );
  }
}