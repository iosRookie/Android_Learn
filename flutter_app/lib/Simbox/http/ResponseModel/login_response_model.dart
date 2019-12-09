class LoginResponseModel {
  List<FsServerInfoVOList> fsServerInfoVOList;
  SipUserVO sipUserVO;
  UserLoginVO userLoginVO;

  LoginResponseModel({this.fsServerInfoVOList, this.sipUserVO, this.userLoginVO});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['fsServerInfoVOList'] != null) {
      fsServerInfoVOList = new List<FsServerInfoVOList>();
      json['fsServerInfoVOList'].forEach((v) {
        fsServerInfoVOList.add(new FsServerInfoVOList.fromJson(v));
      });
    }
    sipUserVO = json['sipUserVO'] != null
        ? new SipUserVO.fromJson(json['sipUserVO'])
        : null;
    userLoginVO = json['userLoginVO'] != null
        ? new UserLoginVO.fromJson(json['userLoginVO'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.fsServerInfoVOList != null) {
      data['fsServerInfoVOList'] =
          this.fsServerInfoVOList.map((v) => v.toJson()).toList();
    }
    if (this.sipUserVO != null) {
      data['sipUserVO'] = this.sipUserVO.toJson();
    }
    if (this.userLoginVO != null) {
      data['userLoginVO'] = this.userLoginVO.toJson();
    }
    return data;
  }
}

class FsServerInfoVOList {
  String codec;
  String country;
  int flag;
  int heartThrob;
  int heartbeatInterval;
  int heartbeatTimeOut;
  double latitude;
  double longitude;
  int mediaPort;
  String mediaprotocol;
  int port;
  String privateip;
  String publicip;
  int registRetryInterval;
  int registRetryNum;
  int resultSort;
  String serverType;
  String servername;
  String status;
  String timestamp;
  String tlsport;
  String transport;
  String transprotocol;
  String uniqueid;
  String version;

  FsServerInfoVOList(
      {this.codec,
        this.country,
        this.flag,
        this.heartThrob,
        this.heartbeatInterval,
        this.heartbeatTimeOut,
        this.latitude,
        this.longitude,
        this.mediaPort,
        this.mediaprotocol,
        this.port,
        this.privateip,
        this.publicip,
        this.registRetryInterval,
        this.registRetryNum,
        this.resultSort,
        this.serverType,
        this.servername,
        this.status,
        this.timestamp,
        this.tlsport,
        this.transport,
        this.transprotocol,
        this.uniqueid,
        this.version});

  FsServerInfoVOList.fromJson(Map<String, dynamic> json) {
    codec = json['codec'];
    country = json['country'];
    flag = json['flag'];
    heartThrob = json['heart_throb'];
    heartbeatInterval = json['heartbeatInterval'];
    heartbeatTimeOut = json['heartbeatTimeOut'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    mediaPort = json['mediaPort'];
    mediaprotocol = json['mediaprotocol'];
    port = json['port'];
    privateip = json['privateip'];
    publicip = json['publicip'];
    registRetryInterval = json['registRetryInterval'];
    registRetryNum = json['registRetryNum'];
    resultSort = json['resultSort'];
    serverType = json['serverType'];
    servername = json['servername'];
    status = json['status'];
    timestamp = json['timestamp'];
    tlsport = json['tlsport'];
    transport = json['transport'];
    transprotocol = json['transprotocol'];
    uniqueid = json['uniqueid'];
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codec'] = this.codec;
    data['country'] = this.country;
    data['flag'] = this.flag;
    data['heart_throb'] = this.heartThrob;
    data['heartbeatInterval'] = this.heartbeatInterval;
    data['heartbeatTimeOut'] = this.heartbeatTimeOut;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['mediaPort'] = this.mediaPort;
    data['mediaprotocol'] = this.mediaprotocol;
    data['port'] = this.port;
    data['privateip'] = this.privateip;
    data['publicip'] = this.publicip;
    data['registRetryInterval'] = this.registRetryInterval;
    data['registRetryNum'] = this.registRetryNum;
    data['resultSort'] = this.resultSort;
    data['serverType'] = this.serverType;
    data['servername'] = this.servername;
    data['status'] = this.status;
    data['timestamp'] = this.timestamp;
    data['tlsport'] = this.tlsport;
    data['transport'] = this.transport;
    data['transprotocol'] = this.transprotocol;
    data['uniqueid'] = this.uniqueid;
    data['version'] = this.version;
    return data;
  }
}

class SipUserVO {
  String customerId;
  String mvnoCode;
  String mvnoId;
  String mvnoName;
  String operator;
  String orgCode;
  String orgId;
  String orgName;
  String realCode;
  String sipCode;
  String sipPwd;
  String sipType;

  SipUserVO(
      {this.customerId,
        this.mvnoCode,
        this.mvnoId,
        this.mvnoName,
        this.operator,
        this.orgCode,
        this.orgId,
        this.orgName,
        this.realCode,
        this.sipCode,
        this.sipPwd,
        this.sipType});

  SipUserVO.fromJson(Map<String, dynamic> json) {
    customerId = json['customerId'];
    mvnoCode = json['mvnoCode'];
    mvnoId = json['mvnoId'];
    mvnoName = json['mvnoName'];
    operator = json['operator'];
    orgCode = json['orgCode'];
    orgId = json['orgId'];
    orgName = json['orgName'];
    realCode = json['realCode'];
    sipCode = json['sipCode'];
    sipPwd = json['sipPwd'];
    sipType = json['sipType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customerId'] = this.customerId;
    data['mvnoCode'] = this.mvnoCode;
    data['mvnoId'] = this.mvnoId;
    data['mvnoName'] = this.mvnoName;
    data['operator'] = this.operator;
    data['orgCode'] = this.orgCode;
    data['orgId'] = this.orgId;
    data['orgName'] = this.orgName;
    data['realCode'] = this.realCode;
    data['sipCode'] = this.sipCode;
    data['sipPwd'] = this.sipPwd;
    data['sipType'] = this.sipType;
    return data;
  }
}

class UserLoginVO {
  String accessToken;
  bool changImeiFlag;
  String currencyType;
  String enterpriseRemark;
  String firstname;
  String lastname;
  String mvnoCode;
  String mvnoId;
  String mvnoName;
  String orgCode;
  String orgId;
  String orgName;
  String payType;
  String registerCountry;
  String userCode;
  String userId;

  UserLoginVO(
      {this.accessToken,
        this.changImeiFlag,
        this.currencyType,
        this.enterpriseRemark,
        this.firstname,
        this.lastname,
        this.mvnoCode,
        this.mvnoId,
        this.mvnoName,
        this.orgCode,
        this.orgId,
        this.orgName,
        this.payType,
        this.registerCountry,
        this.userCode,
        this.userId});

  UserLoginVO.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    changImeiFlag = json['changImeiFlag'];
    currencyType = json['currencyType'];
    enterpriseRemark = json['enterpriseRemark'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    mvnoCode = json['mvnoCode'];
    mvnoId = json['mvnoId'];
    mvnoName = json['mvnoName'];
    orgCode = json['orgCode'];
    orgId = json['orgId'];
    orgName = json['orgName'];
    payType = json['payType'];
    registerCountry = json['registerCountry'];
    userCode = json['userCode'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['changImeiFlag'] = this.changImeiFlag;
    data['currencyType'] = this.currencyType;
    data['enterpriseRemark'] = this.enterpriseRemark;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['mvnoCode'] = this.mvnoCode;
    data['mvnoId'] = this.mvnoId;
    data['mvnoName'] = this.mvnoName;
    data['orgCode'] = this.orgCode;
    data['orgId'] = this.orgId;
    data['orgName'] = this.orgName;
    data['payType'] = this.payType;
    data['registerCountry'] = this.registerCountry;
    data['userCode'] = this.userCode;
    data['userId'] = this.userId;
    return data;
  }
}
