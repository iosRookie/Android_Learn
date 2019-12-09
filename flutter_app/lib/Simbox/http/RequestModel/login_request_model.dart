import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

class LoginRequestModel {
  String apnsToken = "61ecab5add5043c601e441a6f45ad772bc9555214dab8a687ad1d3d0bdde0fe9";
  bool autoLogin = false;
  String channelType = "APP";
  String clientId = "2qqpsi3bqr4tv01lj4drj3lneypv6qhh";
  String clientSecret = "8thsgtircmfqsmlurs61sskvhpo6wkzt";
  String deviceType = Platform.isAndroid ? "ANDROID" : "iOS";
  String devsn = "CDEB38D1-B792-4B6B-A6BE-A0C526180F02";
  String enterpriseCode = "EA00000484";
  String ext = "";
  String hardwareVersion = "iPhone 7";
  String imei = "CDEB38D1-B792-4B6B-A6BE-A0C526180F02";
  String loginCustomerId = "";
  String loginType = "PHONE";
  String mobileBrand = "Apple";
  int num = 6;
  String partnerCode = "UKAPP";
  String pushPlatform = "Apple-debug";
  String sipType = "USER";
  String softVersion = "GlocalMe Call V1.8.00";
  String sound = "shortring.caf";
  String streamNo = "SIMBOXC4B75C79_7106_4CA8_9C55_0FA8997C1CF9";
  String systemVersion = "10.3.3";
  String timestamp = "1575008421000";
  String token = "65cc6fbfbf76c41dc5e37e2179b5a4c4c124d39bffb4ef1ba57a56b33979bed3";
  String tokenType = "pushkit-token";           //Android 不传
  String userCode;
  String password;
  String golcalmeAccount;
  String countryCode;

  LoginRequestModel({this.autoLogin = false, this.countryCode, this.password, this.userCode}):
        assert(countryCode != null),
        assert(userCode != null),
        assert(password != null) {
    if (loginType == "EMAIL") {
      imei = "000000000000000";
      this.golcalmeAccount = this.userCode;
    } else {
      this.golcalmeAccount = this.countryCode + this.userCode;
    }
    this.password = generateMd5(this.password);
  }

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    apnsToken = json['apnsToken'];
    autoLogin = json['autoLogin'];
    channelType = json['channelType'];
    clientId = json['clientId'];
    clientSecret = json['clientSecret'];
    countryCode = json['countryCode'];
    devsn = json['devsn'];
    enterpriseCode = json['enterpriseCode'];
    ext = json['ext'];
    hardwareVersion = json['hardwareVersion'];
    imei = json['imei'];
    loginCustomerId = json['loginCustomerId'];
    loginType = json['loginType'];
    mobileBrand = json['mobileBrand '];
    num = json['num'];
    partnerCode = json['partnerCode'];
    password = generateMd5(json['password']);
    pushPlatform = json['pushPlatform'];
    sipType = json['sipType'];
    softVersion = json['softVersion'];
    sound = json['sound'];
    streamNo = json['streamNo'];
    systemVersion = json['systemVersion'];
    timestamp = json['timestamp'];
    token = json['token'];
    tokenType = json['tokenType'];
    userCode = json['userCode'];
    golcalmeAccount = json['golcalmeAccount'];
    if (loginType == "EMAIL") {
      imei = "000000000000000";
      this.golcalmeAccount = this.userCode;
    } else {
      this.golcalmeAccount = this.countryCode + this.userCode;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['apnsToken'] = this.apnsToken;
    data['autoLogin'] = this.autoLogin.toString();
    data['channelType'] = this.channelType;
    data['clientId'] = this.clientId;
    data['clientSecret'] = this.clientSecret;
    data['countryCode'] = this.countryCode;
    data['deviceType'] = this.deviceType;
    data['devsn'] = this.devsn;
    data['enterpriseCode'] = this.enterpriseCode;
    data['ext'] = this.ext;
    data['golcalmeAccount'] = this.golcalmeAccount;
    data['hardwareVersion'] = this.hardwareVersion;
    data['imei'] = this.imei;
    data['loginCustomerId'] = this.loginCustomerId;
    data['loginType'] = this.loginType;
    data['mobileBrand '] = this.mobileBrand;
    data['num'] = this.num;
    data['partnerCode'] = this.partnerCode;
    data['password'] = this.password;
    data['pushPlatform'] = this.pushPlatform;
    data['sipType'] = this.sipType;
    data['softVersion'] = this.softVersion;
    data['sound'] = this.sound;
    data['streamNo'] = this.streamNo;
    data['systemVersion'] = this.systemVersion;
    data['timestamp'] = this.timestamp;
    data['token'] = this.token;
    data['tokenType'] = this.tokenType;
    data['userCode'] = this.userCode;
    return data;
  }

  // md5 加密
  String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    // 这里其实就是 digest.toString()
    return hex.encode(digest.bytes);
  }
}

