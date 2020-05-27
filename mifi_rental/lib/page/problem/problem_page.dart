import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:mifi_rental/base/base_page.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/problem/privacy_policy_provider.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProblemPage extends BasePage {
  @override
  Widget doBuild(BuildContext context, Widget scaffold) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => getProvider<PrivacyPolicyProvider>()),
    ], child: scaffold);
  }

  @override
  List<BaseProvider> setProviders() {
    return [PrivacyPolicyProvider()];
  }

  @override
  PreferredSizeWidget setAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: color_bg_FFFFFF,
      brightness: Brightness.light,
      title: Text(
        MyLocalizations.of(context).getString(problem),
        style: TextStyle(fontSize: sp_title),
      ),
      centerTitle: true,
      leading: GestureDetector(
          onTap: () {
            FlutterBoost.singleton.closeCurrent();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: color_bg_333333,
          )),
    );
  }

  @override
  Widget setBody(BuildContext context) {
    return _Web();
  }
}

class _Web extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PrivacyPolicyProvider provider =
        Provider.of<PrivacyPolicyProvider>(context);
    if (provider.url == null) {
      return Container();
    }
    return WebView(
      initialUrl: provider.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        if (provider.url != null && !provider.url.startsWith('http')) {
          _loadHtmlFromAssets(webViewController, 'files/${provider.url}');
        }
      },
      onPageStarted: (url) {

      },
      onPageFinished: (url) {

      },
      onWebResourceError: (error) {

      },
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
