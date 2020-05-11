import 'package:flutter_app/Simbox/common/mvp/base_page_presenter.dart';
import 'package:flutter_app/Simbox/http/http_Api.dart';
import 'package:flutter_app/Simbox/http/http_util.dart';
import 'package:flutter_app/Simbox/login/model/country_code_model.dart';
import 'package:flutter_app/Simbox/login/page/country_code_select_page.dart';
import 'package:lpinyin/lpinyin.dart';

class CountryCodeSelectPresenter extends BasePagePresenter<CountryCodeSelectPageState> {
  getCountryCodeList() {
    Future.delayed(Duration.zero, () {
      view?.showProgress();
    });
    HttpUtil().asyncRequestNetwork<CountryCodeModel>(Method.post, HTTPApi.QueryCountryCode,
        isList: true,
        params: {"langType":"zh-CN", "streamNo":"SIMBOXC4B75C79_7106_4CA8_9C55_0FA8997C1CF9","partnerCode":"UKAPP"},
        onSuccessList: ((list) {
          view?.setListDatas(_generateDisplayDatas(list));
          view?.closeProgress();
        }), onError: ((code, message) {

          view?.closeProgress();
        }));
  }
}

Map<String, List<CountryCodeModel>> _generateDisplayDatas(List<CountryCodeModel> list) {
  Map<String, List<CountryCodeModel>> sections = Map();
  list.forEach((model) {
    if (model.countryName.isNotEmpty && model.telprex!=null && model.telprex.isNotEmpty) {
      model.sPinyin = PinyinHelper.getShortPinyin(model.countryName);
      model.firstChar = model.sPinyin[0].toUpperCase();
      if (sections.containsKey(model.firstChar)) {
        List<CountryCodeModel> items = sections[model.firstChar];
        items.add(model);
        sections[model.firstChar] = items;
      } else {
        List<CountryCodeModel> items = List();
        items.add(model);
        sections[model.firstChar] = items;
      }
    }
  });

  return sections;
}
