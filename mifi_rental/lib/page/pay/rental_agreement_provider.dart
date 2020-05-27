import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/rent_agreement_repository.dart';
import 'package:mifi_rental/repository/terminal_repository.dart';

class RentalAgreementProvider extends BaseProvider with ChangeNotifier {
  String agreement;

  set setAgreement(String agreement) {
    this.agreement = agreement;
    notifyListeners();
  }

  void getAgreement(String sn) {
    var langType = MyLocalizations.of(context).getLanguage();
    TerminalRepository().queryTerminalInfo(
        langType: langType,
        terminalSn: sn,
        success: (t) {
          RentAgreementRepository().getAgreement(
              mvno: t.mvnoCode,
              langType: langType,
              success: ((str) {
                setAgreement = str;
              }));
        },
        error: (e) {
          handleError(e);
        });
  }

  @override
  void init() {}
}
