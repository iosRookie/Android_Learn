import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Simbox/common/mvp/BasePageState.dart';
import 'package:flutter_app/Simbox/http/HTTPApi.dart';
import 'package:flutter_app/Simbox/http/HttpUtil.dart';

import 'package:flutter_app/Simbox/http/RequestModel/LoginRequestModel.dart';
import 'package:flutter_app/Simbox/http/ResponseModel/LoginResponseModel.dart';
import 'package:flutter_app/Simbox/login/LoginRouter.dart';
import 'package:flutter_app/Simbox/login/presenter/LoginPresenter.dart';
import 'package:flutter_app/Simbox/res/colors.dart';
import 'package:flutter_app/Simbox/routes/FluroNavigator.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends BasePageState<LoginPage, LoginPresenter> with AutomaticKeepAliveClientMixin<LoginPage> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey _formKey = GlobalKey<FormState>();
  String telprex = "86";

  @override
  LoginPresenter createPresenter() => LoginPresenter();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(
                    vertical: 80.0, horizontal: 25.0),
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
                        child: GestureDetector(
                          child: Stack(
                            children: <Widget>[
                              SizedBox(height: 44, child: Container(color: Colors.transparent,),),
                              Row(
                                children: <Widget>[
                                  Text("国家/地区"),
                                  Text("+$telprex"),
                                  Icon(
                                    Icons.arrow_forward_ios
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 43.5),
                                child: Container(
                                  color: SColors.divider_color,
                                  height: 0.5,
                                ),
                              ),

                            ],
                          ),
                          onTap: (() {
                            _gotoCountryCodeSelectPage();
                          }),
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
                                borderSide: BorderSide(
                                    width: 0.5, color: SColors.theme_color)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: SColors.divider_color)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: SColors.divider_color)),
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
                                borderSide: BorderSide(
                                    width: 0.5, color: SColors.theme_color)),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: SColors.divider_color)),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.5, color: SColors.divider_color)),
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
//                              if ((_formKey.currentState as FormState)
//                                  .validate()) {
                                  //验证通过提交数据
//                                  _gotoLoginPage();
                                  _gotoMainHomePage();
//                              }
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 15.0),
                                  child: Text("确定"),
                                ),
                                color: SColors.theme_color,
                                textColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ))));
  }

  void _gotoLoginPage() async {
    HttpUtil().asyncRequestNetwork<LoginResponseModel>(
        Method.post,
        HTTPApi.LoginApi,
        params: LoginRequestModel(countryCode: "86", password: "123456", userCode: "15991270411").toJson(),
        onSuccess: ((value) {
            NavigatorUtils.push(context, LoginRouter.registerPage);
        }),
        onError: ((code, message) {

        }));
  }

  _gotoCountryCodeSelectPage() {
    NavigatorUtils.pushResult(context, LoginRouter.countryCodeSelectPage, (object) {
      setState(() {
        telprex = (object as Map)["telprex"];
      });
    });
  }

  _gotoMainHomePage() {
    NavigatorUtils.push(context, LoginRouter.mainHomePage, clearStack: true, replace: true);
  }
}
