import 'package:flutter/material.dart';

class PersonHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonHomePageState();
  }
}

class PersonHomePageState extends State<PersonHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('个人'),
      ),
      body: Center(
        child: Text('个人'),
      ),
    );
  }
}