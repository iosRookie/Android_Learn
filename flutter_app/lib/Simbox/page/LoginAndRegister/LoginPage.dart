import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Simbox/http/HttpUtil.dart';

import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Color themeColor = Theme.of(context).primaryColor;
    // 状态栏颜色
    SystemChrome.setSystemUIOverlayStyle(
        Theme.of(context).brightness == Brightness.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark);
    return Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomPadding: true,
        body: SingleChildScrollView(
            child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 80.0, horizontal: 25.0),
            child: Form(
              key: _formKey, //设置globalKey，用于后面获取FormState
              autovalidate: true, //开启自动校验
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Text(
                      "手机登录",
                      style: TextStyle(
                          fontSize: 24.0, fontWeight: FontWeight.w700),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      cursorWidth: 1.0,
                      controller: _unameController,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "手机号码/GlocalMe手机账户",
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.5, color: themeColor)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0.5)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0.5)),
                        errorBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.5, color: Colors.red)),
                      ),
                      validator: (v) {
                        return v.trim().length > 0 ? null : "用户名不能为空";
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: TextFormField(
                      cursorColor: Theme.of(context).primaryColor,
                      cursorWidth: 1.0,
                      controller: _pwdController,
                      style: TextStyle(fontSize: 16, color: Colors.black),
                      decoration: InputDecoration(
                        hintText: "登陆密码",
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.5, color: themeColor)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0.5)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(width: 0.5)),
                        errorBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 0.5, color: Colors.red)),
                      ),
                      obscureText: true,
                      validator: (v) {
                        return v.trim().length > 5 ? null : "密码不能少于6位";
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            onPressed: () {
                              if ((_formKey.currentState as FormState)
                                  .validate()) {
                                //验证通过提交数据
                                _gotoLogin();
                              }
                            },
                            child: Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                              child: Text("确定"),
                            ),
                            color: themeColor,
                            textColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
        )));
  }
  
  void _gotoLogin() async {
     Future<Response> response = HttpUtil().post("/tss/usermanager/user/appLogin", {
       "apnsToken":"61ecab5add5043c601e441a6f45ad772bc9555214dab8a687ad1d3d0bdde0fe9",
       "autoLogin":"0",
       "channelType":"APP",
       "clientId":"2qqpsi3bqr4tv01lj4drj3lneypv6qhh",
       "clientSecret":"8thsgtircmfqsmlurs61sskvhpo6wkzt",
       "countryCode":"86",
       "deviceType":"iOS",
       "devsn":"CDEB38D1-B792-4B6B-A6BE-A0C526180F02",
       "enterpriseCode":"EA00000484",
       "ext":"",
       "golcalmeAccount":"8615991270411",
       "hardwareVersion":"iPhone 7",
       "imei":"CDEB38D1-B792-4B6B-A6BE-A0C526180F02",
       "loginCustomerId":"",
       "loginType":"PHONE",
       "mobileBrand ":"Apple",
       "num":"6",
       "password":"e10adc3949ba59abbe56e057f20f883e",
       "pushPlatform":"Apple-debug",
       "sipType":"USER",
       "softVersion":"GlocalMe Call V1.8.00",
       "sound":"shortring.caf",
       "streamNo":"SIMBOXC4B75C79_7106_4CA8_9C55_0FA8997C1CF9",
       "systemVersion":"10.3.3",
       "timestamp":"1575008421000",
       "token":" 65cc6fbfbf76c41dc5e37e2179b5a4c4c124d39bffb4ef1ba57a56b33979bed3",
       "tokenType":"pushkit-token",
       "userCode":" 15991270411",
     });

     response.then((value) {
        debugPrint("");
     }).catchError((error) {
       debugPrint("");
     });
  }

  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}
