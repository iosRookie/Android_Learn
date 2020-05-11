import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Simbox/common/mvp/base_page_state.dart';
import 'package:flutter_app/Simbox/http/http_Api.dart';
import 'package:flutter_app/Simbox/http/http_util.dart';

import 'package:flutter_app/Simbox/http/RequestModel/login_request_model.dart';
import 'package:flutter_app/Simbox/http/ResponseModel/login_response_model.dart';
import 'package:flutter_app/Simbox/login/login_router.dart';
import 'package:flutter_app/Simbox/login/presenter/login_presenter.dart';
import 'package:flutter_app/Simbox/res/colors.dart';
import 'package:flutter_app/Simbox/routes/fluro_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends BasePageState<LoginPage, LoginPresenter>
    with AutomaticKeepAliveClientMixin<LoginPage> {
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
                          child: _countryCodeSelect()),
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

  Widget _countryCodeSelect() {
    return GestureDetector(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(bottom: 10.0),
//            color: Colors.red,
            height: 44,
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child: Text("国家/地区")
                ),
                Expanded(
                  flex: 5,
                  child: Text("+$telprex"),
                ),
//                Expanded(
//                    child:
                    Icon(Icons.arrow_forward_ios, size: 18, color: SColors.divider_color,)
//                )
              ],
            ),
          ),
          Container(
            color: SColors.divider_color,
            height: 0.5,
          ),
        ],
      ),
      onTap: (() {
        _gotoCountryCodeSelectPage();
      }),
    );
  }

  void _gotoMainHomePage() async {

    NavigatorUtils.push(context, LoginRouter.mainHomePage, clearStack: true, replace: true);
    return;

    SharedPreferences sp = await SharedPreferences.getInstance();
    HttpUtil().asyncRequestNetwork<LoginResponseModel>(
        Method.post, HTTPApi.LoginApi,
        params: LoginRequestModel(
                countryCode: "86", password: "123456", userCode: "15991270411")
            .toJson(), onSuccess: ((value) {
      sp.setBool("hasLogin", true);
      NavigatorUtils.push(context, LoginRouter.mainHomePage, clearStack: true, replace: true);
//          NavigatorUtils.push(context, LoginRouter.registerPage);
    }), onError: ((code, message) {}));
  }

  _gotoCountryCodeSelectPage() {
    NavigatorUtils.pushResult(context, LoginRouter.countryCodeSelectPage,
            (object) {
                setState(() {
                    telprex = (object as Map)["telprex"];
                  });
            });
  }


}
