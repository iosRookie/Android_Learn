import 'package:flutter_app/Simbox/common/mvp/BasePagePresenter.dart';
import 'package:flutter_app/Simbox/http/HTTPApi.dart';
import 'package:flutter_app/Simbox/http/HttpUtil.dart';
import 'package:flutter_app/Simbox/login/model/CountryCodeModel.dart';
import 'package:flutter_app/Simbox/login/page/CountryCodeSelectPage.dart';

class CountryCodeSelectPresenter extends BasePagePresenter<CountryCodeSelectPageState> {
  getCountryCodeList() {
    view?.showProgress();
    HttpUtil().asyncRequestNetwork<CountryCodeModel>(Method.post, HTTPApi.QueryCountryCode,
        isList: true,
        params: {"langType":"zh-CN", "streamNo":"SIMBOXC4B75C79_7106_4CA8_9C55_0FA8997C1CF9","partnerCode":"UKAPP"},
        onSuccessList: ((list) {
          view?.setListDatas(list);
          view?.closeProgress();
        }), onError: ((code, message) {

          view?.closeProgress();
        }));
  }
}
