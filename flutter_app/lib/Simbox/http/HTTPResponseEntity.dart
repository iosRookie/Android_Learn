import 'package:flutter_app/Simbox/http/ResponseModel/LoginResponseModel.dart';

class HTTPResponseEntity<T>{

  String resultCode;
  String resultDesc;
  int responseDt;
  String streamNo;
  T data;
  List<T> listData = [];

  HTTPResponseEntity(this.resultCode, this.resultDesc, {this.responseDt, this.streamNo, this.data});

  HTTPResponseEntity.fromJson(Map<String, dynamic> json) {
    resultCode = json['resultCode'];
    resultDesc = json['resultDesc'];
    streamNo = json['streamNo'];
    responseDt = json['responseDt'];
    if (json.containsKey('data')){
      if (json['data'] is List) {
        (json['data'] as List).forEach((item){
          listData.add(EntityFactory.generateOBJ<T>(item));
        });
      }else {
        if (T.toString() == "String"){
          data = json['data'].toString() as T;
        }else if (T.toString() == "Map<dynamic, dynamic>"){
          data = json['data'] as T;
        }else {
          data = EntityFactory.generateOBJ(json['data']);
        }
      }
    }
  }
}

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (T.toString() == "LoginResponseModel") {
      return LoginResponseModel.fromJson(json) as T;
    } else {
      return null;
    }
  }
}