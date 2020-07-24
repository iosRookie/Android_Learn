import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:mifi_rental/common/preference_key.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/connect_util.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum BottomSheetType {
    user_agreement,
    privacy_policy
}

class CustomBottomSheetPage extends StatefulWidget {
  final BottomSheetType type;
  final bool showActions;
  CustomBottomSheetPage(this.type, this.showActions);
  @override
  State<StatefulWidget> createState() {
    return CustomBottomSheetPageState();
  }
}

class CustomBottomSheetPageState extends State<CustomBottomSheetPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
            color: Color.fromRGBO(0, 0, 0, 0.3),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                    )
                ),
                child: _content(context, widget.type),
              ),
            )
        ),
      )
    );
  }

  Widget _content(BuildContext context, BottomSheetType type) {
    if (type == BottomSheetType.user_agreement) {
      return _user_agreement(context);
    }else if (type == BottomSheetType.privacy_policy) {
      return _privacy_policy_page(context);
    } else {
      return Container();
    }
  }

  Widget _privacy_policy_page(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(Padding(
      padding: EdgeInsets.only(bottom: dp_frame, top: dp_frame),
      child: Text(
        MyLocalizations.of(context).getString(privacy_policy),
        style: TextStyle(fontSize: sp_16, color: color_text_333333, fontWeight: FontWeight.w700),
      ),
    ));

      widgets.add(Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Container(
            height: 220.0,
            child: WebView(
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  ConnectUtil.isConnected().then((b) {
                    String url;
                    final String language = MyLocalizations.of(context).getLanguage();
                    String file = '';
                    if (language.startsWith('zh')) {
                      file = 'privacy_policy_${language.toLowerCase()}.html';
                    } else {
                      file = 'privacy_policy_en.html';
                    }
                    if (b) {
                      url = '${UrlApi.DOCUMENT_HOST}MiFiRent/Public/' + file;
                      webViewController.loadUrl(url);
                    } else {
                      _loadHtmlFromAssets(webViewController, 'files/$file');
                    }
                  });
                })
        ),
      ));

    return Container(
        height: 300.0,
        child: Column(
          children: widgets,
        )
    );
  }

  Widget _user_agreement(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(Padding(
      padding: EdgeInsets.only(bottom: dp_frame, top: dp_frame),
      child: Text(
        MyLocalizations.of(context).getString(user_agreement),
        style: TextStyle(fontSize: sp_16, color: color_text_333333, fontWeight: FontWeight.w700),
      ),
    ));

    widgets.add(Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: Container(
          height: 220.0,
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              ConnectUtil.isConnected().then((b) {
                String url;
                var language = MyLocalizations.of(context).getLanguage();
                var file;
                if (language.startsWith('zh')) {
                  file = 'user_treaty_${language.toLowerCase()}.html';
                } else {
                  file = 'user_treaty_en.html';
                }

                if (b) {
                  url = '${UrlApi.DOCUMENT_HOST}MiFiRent/Public/' + file;
                  webViewController.loadUrl(url);
                } else {
                  _loadHtmlFromAssets(webViewController, 'files/$file');
                }
              });
            },
          )
      ),
    )
    );

    if (widget.showActions) {
      widgets.add(
         Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                Container(
                    height: 44,
                    width: (MediaQuery.of(context).size.width - 3*16)/2.0,
                    child: OutlineButton(
                      onPressed: () {
                        SharedPreferenceUtil.setBool(USER_AGREEMENT, false);
                        Navigator.pop(context);
                      },
                      child: Text(
                        MyLocalizations.of(context).getString(disagree),
                        style: TextStyle(color: color_text_999999),
                      ),
                    )
                ),
                Container(
                    height: 44,
                    width: (MediaQuery.of(context).size.width - 3*16)/2.0,
                    child:FlatButton(
                  color: color_theme,
                  onPressed: () {
                    SharedPreferenceUtil.setBool(USER_AGREEMENT, true);
                    Navigator.pop(context);
                  },
                  child: Text(
                    MyLocalizations.of(context).getString(agree),
                    style: TextStyle(color: Colors.white),
                  ),
                )
                )
              ],
            ),
          )
      );
    }

    return Container(
        height: widget.showActions ? 360.0 : 300,
        child: Column(
          children: widgets,
        )
    );
  }

  _loadHtmlFromAssets(
      WebViewController webViewController, String filePath) async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}

class SimpleRoute extends PageRoute {
  SimpleRoute({
    @required this.name,
    @required this.title,
    @required this.builder,
  }) : super(
    settings: RouteSettings(name: name),
  );

  final String title;
  final String name;
  final WidgetBuilder builder;

  @override
  String get barrierLabel => null;

  @override
  bool get opaque => false;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 0);

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return Title(
      title: title,
      color: Theme.of(context).primaryColor,
      child: builder(context),
    );
  }

  /// 页面切换动画
  @override
  Widget buildTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
      ) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  @override
  Color get barrierColor => null;
}


class CustomBottomSheetDialog {
  static show(BuildContext context, BottomSheetType type, {bool showActions = false}) {
    Navigator.of(context).push(SimpleRoute(
        name: '',
        title: '',
        builder: (context){
          return CustomBottomSheetPage(type, showActions);
        }));
  }
}
