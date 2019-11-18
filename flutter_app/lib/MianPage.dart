import 'package:flutter/material.dart';
import 'package:flutter_app/ArticleListScreen.dart';

class MainNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      initialRoute: "home",
      onGenerateRoute: (RouteSettings settings){
        WidgetBuilder builder;
        switch (settings.name) {
          case 'home':
            builder = (BuildContext context) => MainPage();
            break;
          case 'dome1':
            builder = (BuildContext context) => ArticleListScreen();
            break;
          default:
            throw Exception('Invalid route:${settings.name}');
        }

        return MaterialPageRoute(builder: builder, settings: settings);
      },
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Main"),),
      body: Center(
        child: RaisedButton(
          child: Text("Dome1"),
          onPressed: (){
            Navigator.of(context).pushNamed("dome1");
          },
        ),
      ),
    );
  }
}