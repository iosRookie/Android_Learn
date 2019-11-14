import 'dart:io';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/FavoriteWidget.dart';
import 'package:flutter_app/ListViewWidget.dart';
import 'package:flutter_app/MyAppBar.dart';
import 'package:flutter_app/RandomWords.dart';
import 'package:flutter_app/TapboxA.dart';
import 'package:flutter_app/TapboxB.dart';
import 'package:flutter_app/TapboxC.dart' as C;
import 'package:flutter_app/TutorialHome.dart';

void main() {
  runApp(
      MyApp()
  );
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      theme: new ThemeData(
//        primaryColor: Colors.white
//      ),
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('App'),
//          centerTitle: true,
//          actions: <Widget>[
//            new IconButton(icon: new Icon(Icons.add), onPressed: null)
//          ],
//        ),
//        body: new Text('123'),
//      ),
//    );
//  }
//}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'My app',
//      home: new TutorialHome()
//      //new MyScaffold()
//    );
//  }
//}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'Welcome to Flutter',
//      theme: new ThemeData(
//          primaryColor: Colors.white
//      ),
//      home: new Scaffold(
//        body: new Center(
//          child: new RandomWords(),
//        ),
//      ),
//    );
//  }
//}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//
//    Widget titleSection = new Container(
//      padding: const EdgeInsets.all(32.0),
//      child: new Row(
//        children: <Widget>[
//          new Expanded(
//            child: new Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                new Container(
//                  padding: const EdgeInsets.only(bottom: 8.0),
//                  child: new Text(
//                    'Oeschinen Lake Camground',
//                    style: new TextStyle(
//                        fontWeight: FontWeight.bold
//                    ),
//                  ),
//                ),
//                new Text(
//                  'Kandersteg, Switzerland',
//                  style: new TextStyle(
//                      color: Colors.grey[500]
//                  ),
//                )
//              ],
//            ),
//          ),
//          new FavoriteWidget()
//        ],
//      ),
//    );
//
//    Column buildButtonColumn(IconData icon, String title) {
//      Color color = Theme
//          .of(context)
//          .primaryColor;
//      return new Column(
//        mainAxisSize: MainAxisSize.min,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: <Widget>[
//          new Icon(icon, color: color),
//          new Container(
//            margin: const EdgeInsets.only(top: 8.0),
//            child: new Text(
//              title,
//              style: new TextStyle(
//                  fontSize: 12.0,
//                  fontWeight: FontWeight.w400,
//                  color: color
//              ),
//            ),
//          )
//        ],
//      );
//    }
//
//    Widget buttonSection = new Container(
//      child: new Row(
//        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//        children: <Widget>[
//          buildButtonColumn(Icons.call, 'CALL'),
//          buildButtonColumn(Icons.near_me, 'ROUTE'),
//          buildButtonColumn(Icons.share, 'SHARE'),
//        ],
//      ),
//    );
//
//    Widget textSection = new Container(
//      padding: const EdgeInsets.all(32.0),
//      child: new Text(
//        '''
//Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
//        ''',
//        softWrap: true,
//      ),
//    );
//
//    return new MaterialApp(
//      title: 'my_app',
//      theme: new ThemeData(
//          primaryColor: Colors.white
//      ),
//      home: new Scaffold(
//        appBar: new AppBar(
//          centerTitle: true,
//          title: new Text(
//            '详情',
//            textAlign: TextAlign.center,
//          ),
//        ),
//          body: new ListView(
//            children: <Widget>[
//              new Image.asset(
//                'Images/lake.jpeg',
//                width: 600,
//                height: 400,
//                fit: BoxFit.cover,
//              ),
//              titleSection,
//              buttonSection,
//              textSection
//            ],
//          )
//      ),
//    );
//  }
//}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'widget管理自己的state',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('widget管理自己的state'),
//        ),
//        body: new Center(
//          child: new TapboxA(),
//        ),
//      ),
//    );
//  }
//}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: '父widget管理widget的state',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('父widget管理widget的state'),
//        ),
//        body: new Center(
//          child: new ParentWidget(),
//        ),
//      ),
//    );
//  }
//}

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: '混合管理widget的state',
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('混合管理widget的state'),
//        ),
//        body: new Center(
//          child: new Column(
//            mainAxisSize: MainAxisSize.max,
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              new Text('widget管理自己的state'),
//              new TapboxA(),
//              new Text('父widget管理widget的state'),
//              new ParentWidget(),
//              new Text('混合管理widget的state'),
//              new C.ParentWidget(),
//            ],
//          )
//        ),
//      ),
//    );
//  }
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ListView learn",
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("ListView Learn"),
        ),
        body: new ListViewWidget(),
      ),
    );
  }
}

















