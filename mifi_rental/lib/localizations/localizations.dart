import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:mifi_rental/res/strings.dart';

class MyLocalizations {
  MyLocalizations(this.locale);

  final Locale locale;

  static MyLocalizations of(BuildContext context) {
    return Localizations.of<MyLocalizations>(context, MyLocalizations);
  }

  String getLanguage() {
    switch (locale.languageCode) {
      case 'zh':
        return 'zh-${locale.countryCode}';
      default:
        return 'en-US';
    }
  }

  String getString(int id) {
    String value;
    switch (locale.languageCode) {
      case 'en':
        value = __localizedEN[id];
        break;
      case 'zh':
        value = _localizedZH[locale.countryCode][id];
        break;
      default:
        value = __localizedEN[id];
    }
    return value != null ? value : '';
  }

  static Map<int, String> __localizedEN = {
    home_page: 'Home',
    user_agreement: '用户协议',
    privacy_policy: '隐私政策',
    scan_wifi_rental: '请扫描面包机上的二维码租赁设备',
    scan: 'Scan',
    agree: 'Agree',
    disagree: 'Disagree',
    last_update: '上次刷新时间:',
    refresh: '刷新',
    surplus_data: '剩余流量',
    buy_data: '流量不够，去购买加油包',
    lease_duration: '租赁时长(小时)',
    buckle_amount: '应付金额(美元)',
    lease_date: '租赁时间',
    device_deposit: '设备押金',
    if_like_device: '如果您喜欢这个设备，您还可以:',
    buy_this_device: '拥有此设备',
    buy_new_device: '购买新设备',
    device_info: '设备信息',
    wifi_name: 'WIFI名称',
    imei: 'IMEI',
    trouble_report: '故障申报',
    pay: '支付',
    paypal: 'Paypal',
    pay_type: '支付方式',
    paypal_tip: '由于Paypal的认证机制，请不要用电子支票和银行转账。',
    lease_tip: '租赁使用规则',
    expend_all: '展开全部',
    pay_amount: '支付金额',
    go_pay: '去支付',
    buckle_tip: '还机后剩余押金将自动原路退还',
    problem: '常见问题',
    rent_fail: '租赁失败',
    pay_fail: '支付失败',
    pay_fail_tip: '未支付成功，请重新支付',
    repay: '重新支付',
    flow_package: '加油包',
    choose_package: '选择加油包',
    notice_for_use: '使用须知',
    rent_success: '租赁成功',
    no_rent_device: '无可租设备',
    no_rent_device_detail: '非常抱歉，机器内已无可租设备！',
    return_home: '返回首页',
    device_pop_up: '设备已弹出',
    take_your_equipment: '请拿好您的设备,开机即可享受WIFI服务!',
    check_device_information: '查看设备信息',
    rent_tip: '获取设备后请在5分钟内进行检查，如果发现有问题请点击“故障申告”进行反馈，反馈完毕后请将设备插回机器空置仓位，此期间不计费。',
  };

  static Map<String, Map<int, String>> _localizedZH = {
    'CN': {
      home_page: '首页',
      user_agreement: '用户协议',
      privacy_policy: '隐私政策',
      scan_wifi_rental: '请扫描面包机上的二维码租赁设备',
      scan: '扫一扫',
      agree: '同意',
      disagree: '不同意',
      last_update: '上次刷新时间:',
      refresh: '刷新',
      surplus_data: '剩余流量',
      buy_data: '流量不够，去购买加油包',
      lease_duration: '租赁时长(小时)',
      buckle_amount: '应付金额(美元)',
      lease_date: '租赁时间',
      device_deposit: '设备押金',
      if_like_device: '如果您喜欢这个设备，您还可以:',
      buy_this_device: '拥有此设备',
      buy_new_device: '购买新设备',
      device_info: '设备信息',
      wifi_name: 'WIFI名称',
      wifi_password: 'WIFI密码',
      imei: 'IMEI',
      trouble_report: '故障申报',
      pay: '支付',
      paypal: 'Paypal',
      pay_type: '支付方式',
      paypal_tip: '由于Paypal的认证机制，请不要用电子支票和银行转账。',
      lease_tip: '租赁使用规则',
      expend_all: '展开全部',
      pay_amount: '支付金额',
      go_pay: '去支付',
      buckle_tip: '还机后剩余押金将自动原路退还',
      problem: '常见问题',
      rent_fail: '租赁失败',
      pay_fail: '支付失败',
      pay_fail_tip: '未支付成功，请重新支付',
      repay: '重新支付',
      flow_package: '加油包',
      choose_package: '选择加油包',
      notice_for_use: '使用须知',
      rent_success: '租赁成功',
      no_rent_device: '无可租设备',
      no_rent_device_detail: '非常抱歉，机器内已无可租设备！',
      return_home: '返回首页',
      device_pop_up: '设备已弹出',
      take_your_equipment: '请拿好您的设备,开机即可享受WIFI服务!',
      check_device_information: '查看设备信息',
      rent_tip:
          '获取设备后请在5分钟内进行检查，如果发现有问题请点击“故障申告”进行反馈，反馈完毕后请将设备插回机器空置仓位，此期间不计费。',
    },
    'HK': {
      home_page: '首頁',
      user_agreement: '用戶協議',
      privacy_policy: '隱私政策',
      scan_wifi_rental: '請掃描面包機上的二維碼租賃設備',
      scan: '掃一掃',
      agree: '同意',
      disagree: '不同意',
      last_update: '上次刷新時間:',
      refresh: '刷新',
      surplus_data: '剩余流量',
      buy_data: '流量不夠，去購買加油包',
      lease_duration: '租賃時長(小時)',
      buckle_amount: '應付金額(美元)',
      lease_date: '租賃時間',
      device_deposit: '設備押金',
      if_like_device: '如果您喜歡這個設備，您還可以:',
      buy_this_device: '擁有此設備',
      buy_new_device: '購買新設備',
      device_info: '設備信息',
      wifi_name: 'WIFI名稱',
      wifi_password: 'WIFI密碼',
      imei: 'IMEI',
      trouble_report: '故障申報',
      pay: '支付',
      paypal: 'Paypal',
      pay_type: '支付方式',
      paypal_tip: '由於Paypal的認證機制，請不要用電子支票和銀行轉賬。',
      lease_tip: '租賃使用規則',
      expend_all: '展開全部',
      pay_amount: '支付金額',
      go_pay: '去支付',
      buckle_tip: '還機後剩余押金將自動原路退還',
      problem: '常見問題',
      rent_fail: '租賃失敗',
      pay_fail: '支付失敗',
      pay_fail_tip: '未支付成功，請重新支付',
      repay: '重新支付',
      flow_package: '加油包',
      choose_package: '選擇加油包',
      notice_for_use: '使用須知',
      rent_success: '租賃成功',
      no_rent_device: '無可租設備',
      no_rent_device_detail: '非常抱歉，機器內已無可租設備！',
      return_home: '返回首頁',
      device_pop_up: '設備已彈出',
      take_your_equipment: '請拿好您的設備,開機即可享受WIFI服務!',
      check_device_information: '查看設備信息',
      rent_tip:
          '獲取設備後請在5分鐘內進行檢查，如果發現有問題請點擊“故障申告”進行反饋，反饋完畢後請將設備插回機器空置倉位，此期間不計費。',
    },
    'TW': {
      home_page: '首頁',
      user_agreement: '用戶協議',
      privacy_policy: '隱私政策',
      scan_wifi_rental: '請掃描面包機上的二維碼租賃設備',
      scan: '掃一掃',
      agree: '同意',
      disagree: '不同意',
      last_update: '上次刷新時間:',
      refresh: '刷新',
      surplus_data: '剩余流量',
      buy_data: '流量不夠，去購買加油包',
      lease_duration: '租賃時長(小時)',
      buckle_amount: '應付金額(美元)',
      lease_date: '租賃時間',
      device_deposit: '設備押金',
      if_like_device: '如果您喜歡這個設備，您還可以:',
      buy_this_device: '擁有此設備',
      buy_new_device: '購買新設備',
      device_info: '設備信息',
      wifi_name: 'WIFI名稱',
      wifi_password: 'WIFI密碼',
      imei: 'IMEI',
      trouble_report: '故障申報',
      pay: '支付',
      paypal: 'Paypal',
      pay_type: '支付方式',
      paypal_tip: '由於Paypal的認證機制，請不要用電子支票和銀行轉賬。',
      lease_tip: '租賃使用規則',
      expend_all: '展開全部',
      pay_amount: '支付金額',
      go_pay: '去支付',
      buckle_tip: '還機後剩余押金將自動原路退還',
      problem: '常見問題',
      rent_fail: '租賃失敗',
      pay_fail: '支付失敗',
      pay_fail_tip: '未支付成功，請重新支付',
      repay: '重新支付',
      flow_package: '加油包',
      choose_package: '選擇加油包',
      notice_for_use: '使用須知',
      rent_success: '租賃成功',
      no_rent_device: '無可租設備',
      no_rent_device_detail: '非常抱歉，機器內已無可租設備！',
      return_home: '返回首頁',
      device_pop_up: '設備已彈出',
      take_your_equipment: '請拿好您的設備,開機即可享受WIFI服務!',
      check_device_information: '查看設備信息',
      rent_tip:
          '獲取設備後請在5分鐘內進行檢查，如果發現有問題請點擊“故障申告”進行反饋，反饋完畢後請將設備插回機器空置倉位，此期間不計費。',
    }
  };
}
