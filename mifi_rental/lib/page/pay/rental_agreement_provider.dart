import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/repository/conf_repository.dart';
import 'package:mifi_rental/repository/rent_agreement_repository.dart';
import 'package:mifi_rental/repository/terminal_repository.dart';

class RentalAgreementProvider extends BaseProvider with ChangeNotifier {
  String agreement;
  String deposit;

  set setAgreement(String agreement) {
    this.agreement = agreement;
    notifyListeners();
  }

  set setDeposit(String deposit) {
    this.deposit = deposit;
    notifyListeners();
  }

  void getAgreement(String sn) {
    var langType = MyLocalizations.of(context).getLanguage();
    TerminalRepository().queryTerminalInfo(
        langType: langType,
        terminalSn: sn,
        success: (t) {
          ConfigRepository().getConfByMvno(
            mvnoCode: t.mvnoCode,
            langType: langType,
            success: ((config) {
              setDeposit =
                  '${config.currencyType} ${(double.parse(config.depositAmount) / 100).toStringAsFixed(2)}';
            }),
          );

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
