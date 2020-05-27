import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/connect_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPolicyDialog {
  show(BuildContext context) {
    List<Widget> widgets = List();
    widgets.add(Padding(
      padding: EdgeInsets.only(bottom: dp_frame),
      child: Text(
        MyLocalizations.of(context).getString(privacy_policy),
        style: TextStyle(fontSize: sp_16, color: color_text_333333),
      ),
    ));
    ConnectUtil.isConnected().then((b) {
      String url;
      var language = MyLocalizations.of(context).getLanguage();
      var file;
      if (language.startsWith('zh')) {
        file = 'privacy_policy_${language.toLowerCase()}.html';
      } else {
        file = 'privacy_policy_en.html';
      }

      if (b) {
        url = '${UrlApi.DOCUMENT_HOST}MiFiRent/Public/' + file;
      }
      widgets.add(Flexible(
        fit: FlexFit.tight,
        child: Container(
            child: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            if (url == null) {
              _loadHtmlFromAssets(webViewController, 'files/$file');
            }
          },
        )),
      ));

      showDialog(
          context: context,
          builder: (BuildContext context) {
            final size = MediaQuery.of(context).size;
            return AlertDialog(
              content: SizedBox(
                  height: size.height / 2,
                  child: Column(
                    children: widgets,
                  )),
            );
          });
    });
  }

  _loadHtmlFromAssets(
      WebViewController webViewController, String filePath) async {
    String fileHtmlContents = await rootBundle.loadString(filePath);
    webViewController.loadUrl(Uri.dataFromString(fileHtmlContents,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }
}
