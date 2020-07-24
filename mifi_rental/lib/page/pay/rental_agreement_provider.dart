import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/base/base_provider.dart';
import 'package:mifi_rental/entity/config.dart';
import 'package:mifi_rental/net/net_data_analysis_error.dart';
import 'package:mifi_rental/repository/conf_repository.dart';
import 'package:mifi_rental/repository/rent_agreement_repository.dart';
import 'package:mifi_rental/repository/terminal_repository.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';

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

  void getAgreement(String sn, {Function success, Function failure}) {
    Config tempConfig;
    TerminalRepository().queryTerminalInfo(
        terminalSn: sn,
        success: (t) {
          ConfigRepository.getConfByMvno(
            mvnoCode: t.mvnoCode,
            success: ((config) {
              tempConfig = config;
              setDeposit =
                  '${config.currencyType} ${(double.parse(config.depositAmount) / 100).toStringAsFixed(2)}';

              RentAgreementRepository().getAgreement(
                  mvno: t.mvnoCode,
                  success: ((str) {
                    setAgreement = str.replaceAll("\${currencyType}", tempConfig.currencyType)
                        .replaceAll("\${depositAmount}", "${(double.parse(tempConfig.depositAmount) / 100).toStringAsFixed(2)}")
                        .replaceAll("\${perHourPrice}", "${(double.parse(tempConfig.perHourPrice) / 100).toStringAsFixed(2)}")
                        .replaceAll("\${dayMaxPrice}", "${(double.parse(tempConfig.dayMaxPrice) / 100).toStringAsFixed(2)}")
                        .replaceAll("\${maxRentDay}", tempConfig.maxRentDay)
                        .replaceAll("\${salePrice}", "${(double.parse(tempConfig.salePrice) / 100).toStringAsFixed(2)}")
                        .replaceAll("\${maxRentDay}", tempConfig.maxRentDay);
                    success();
                  }),
                  error: (e) {
                    failure();
                    NetDataAnalysisError.showErrorToast(e, context);
                  }
              );
            }),
            error: (e) {
              failure();
              NetDataAnalysisError.showErrorToast(e, context);
            }
          );
        },
        error: (e) {
          failure();
          NetDataAnalysisError.showErrorToast(e, context);
        });
  }

  @override
  void init() {}
}
