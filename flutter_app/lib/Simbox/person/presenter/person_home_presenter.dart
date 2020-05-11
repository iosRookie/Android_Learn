import 'package:flutter_app/Simbox/common/mvp/base_page_presenter.dart';
import 'package:flutter_app/Simbox/person/page/person_home_page.dart';
import 'package:flutter_app/Simbox/res/shared_preferences_config.dart';
import 'package:flutter_app/Simbox/routes/fluro_navigator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../person_router.dart';

class PersonHomePresenter extends BasePagePresenter<PersonHomePageState> {
  SharedPreferences _sp;

  @override
  initState() {
    _initConfigs();
    return super.initState();
  }

  _initConfigs() async{
    _sp = await SharedPreferences.getInstance();
  }

  loginOut() {
    _sp.setBool(SharedPreferencesConfig.HasLogin, false);
    NavigatorUtils.push(view?.context, PersonRouter.loginPage, clearStack: true);
  }
}