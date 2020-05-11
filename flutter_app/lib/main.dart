import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Simbox/common/SimboxLocalizations.dart';
import 'package:flutter_app/Simbox/res/colors.dart';
import 'package:flutter_app/Simbox/routes/application.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Simbox/login/page/login_page.dart';
import 'Simbox/main/Simbox_mian_page.dart';
import 'Simbox/res/shared_preferences_config.dart';
import 'Simbox/routes/routes.dart';

SharedPreferences sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sp = await SharedPreferences.getInstance();
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {
  MyApp() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  State<StatefulWidget> createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//  debugPaintSizeEnabled = true; //直观的调试布局问题
//  debugPaintPointersEnabled = true; //对象都突出显
//  debugPaintBaselinesEnabled = true; //对象的基准线
    return MaterialApp(
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) {
        return SimboxLocalizations.of(context).appName;
      },
      home: loadWidget(),
      theme: ThemeData(primaryColor: SColors.theme_color),
      // 国际化
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SimboxLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('zh', 'CN'), // chinese
      ],
      localeResolutionCallback: (local, supportLocals) {
        return local;
//        return Localizations.localeOf(context); // 应用的当前区域设置
      },
      onGenerateRoute: Application.router.generator,
    );
  }
}

Widget loadWidget() {
  if (sp.containsKey(SharedPreferencesConfig.HasLogin) && sp.getBool(SharedPreferencesConfig.HasLogin)) {
    return SimboxMainPage();
  } else {
    return LoginPage();
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
//  debugPaintSizeEnabled = true; //直观的调试布局问题
////  debugPaintPointersEnabled = true; //对象都突出显
////  debugPaintBaselinesEnabled = true; //对象的基准线
//    return new MaterialApp(
//        title: 'My app',
//        theme: ThemeData(primaryColor: SColors.theme_color),
//        // 国际化
//        localizationsDelegates: [
//          GlobalMaterialLocalizations.delegate,
//          GlobalWidgetsLocalizations.delegate,
//          SimboxLocalizations.delegate
//        ],
//        supportedLocales: [
//          const Locale('en', 'US'), // English
//          const Locale('zh', 'CN'), // chinese
//        ],
//        localeResolutionCallback: (local, supportLocals) {
//          return local;
////        return Localizations.localeOf(context); // 应用的当前区域设置
//        },
//        home: LayoutDome()
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

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return HomeListView(["ListViewLearn", "234", "345"]);
////    return new MaterialApp(
////      title: "ListView learn",
////      home: new Scaffold(
////        appBar: new AppBar(
////          title: new Text("ListView Learn"),
////        ),
////        body: new Container(
////          color: Color.fromRGBO(236, 236, 236, 1),
////          child: new ListViewWidget(),
////        ),
////      ),
////    );
//  }
//}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("First Screen"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Launch second screen"),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Go Back"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
