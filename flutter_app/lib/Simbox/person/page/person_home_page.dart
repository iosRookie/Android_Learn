import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/common/mvp/base_page_state.dart';
import 'package:flutter_app/Simbox/person/presenter/person_home_presenter.dart';
import 'package:flutter_app/Simbox/res/colors.dart';

class PersonHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PersonHomePageState();
  }
}

class PersonHomePageState extends BasePageState<PersonHomePage, PersonHomePresenter> with AutomaticKeepAliveClientMixin<PersonHomePage> {
  @override
  PersonHomePresenter createPresenter() => PersonHomePresenter();

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('个人', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: FloatingActionButton(
          backgroundColor: SColors.theme_color,
          child: Text("退出登录", style: TextStyle(fontSize: 16, color: Colors.white)),
          onPressed: () {
                presenter?.loginOut();
              },
        )
      ),
    );
  }
}