class CountryCodeModel {
  // response data
  String countryName;
  String iso2;
  String iso3;
  String coverFlag;
  String continent;
  String sendFlag;
  String smsFlag;
  String telprex;

  // generate data
  String sPinyin;
  String firstChar;

  CountryCodeModel(
      {this.countryName,
        this.iso2,
        this.iso3,
        this.coverFlag,
        this.continent,
        this.sendFlag,
        this.smsFlag,
        this.telprex});

  CountryCodeModel.fromJson(Map<String, dynamic> json) {
    countryName = json['countryName'];
    iso2 = json['iso2'];
    iso3 = json['iso3'];
    coverFlag = json['coverFlag'];
    continent = json['continent'];
    sendFlag = json['sendFlag'];
    smsFlag = json['smsFlag'];
    telprex = json['telprex'];

    sPinyin = json['sPinyin'];
    firstChar = json['firstChar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['countryName'] = this.countryName;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    data['coverFlag'] = this.coverFlag;
    data['continent'] = this.continent;
    data['sendFlag'] = this.sendFlag;
    data['smsFlag'] = this.smsFlag;
    data['telprex'] = this.telprex;

    data['sPinyin'] = this.sPinyin;
    data['firstChar'] = this.firstChar;
    return data;
  }
}