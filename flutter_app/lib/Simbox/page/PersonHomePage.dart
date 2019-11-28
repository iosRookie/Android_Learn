import 'package:flutter/material.dart';

class PersonHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonHomePageState();
  }
}

class PersonHomePageState extends State<PersonHomePage> with AutomaticKeepAliveClientMixin<PersonHomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

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