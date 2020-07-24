import 'dart:ffi';

import 'package:core_net/core_net.dart';
import 'package:mifi_rental/entity/terminal.dart';
import 'package:mifi_rental/entity/terminal_site.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/base_repository.dart';

class TerminalRepository extends BaseRepository {
  void queryTerminalInfo({
    String terminalSn,
    Function(Terminal) success,
    Function(dynamic) error,
  }) async {
    Map<String, dynamic> params =  await BaseRepository.netCommonParams();
    params.addAll(Map<String, dynamic>.from({'terminalSn': terminalSn}));

    NetClient().post<Terminal>(
      UrlApi.QUERY_TERMINAL_INFO,
      params: params,
      success: ((any) {
        if (any is Terminal) {
          if (success != null) {
            success(any);
          }
        } else {
          if (success != null) {
            success(null);
          }
        }
      }),
      error: ((e) {
        if (error != null) {
          error(e);
        }
      }),
    );
  }

  static void queryTerminalSites(
      String currentLng,
      String currentLat,
      Function(List<dynamic>) success,
      Function(dynamic) error,
      ) async {

      Map<String, dynamic> params =  await BaseRepository.netCommonParams();
      params.addAll(Map<String, dynamic>.from({
        'currentLng': currentLng,
        'currentLat': currentLat}));

    NetClient().post<TerminalSite>(
      UrlApi.QUERY_NEARBY_TERMINAL_INFO,
      params: params,
      success: ((any) {
        if (any is List) {
          if (success != null) {
            success(any);
          }
        } else {
          if (success != null) {
            success(null);
          }
        }
      }),
      error: ((e) {
        if (error != null) {
          error(e);
        }
      }),
    );
  }
}
