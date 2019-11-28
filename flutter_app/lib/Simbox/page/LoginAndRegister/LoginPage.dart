import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        body: Padding(
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
                      autofocus: true,
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
            )));
  }
}
