import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mifi_rental/common/alert_util.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/net/api.dart';
import 'package:mifi_rental/repository/fault_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/net_util.dart';

class FaultReporting extends StatelessWidget {
  final Map params;
  FaultReporting(this.params);
  @override
  Widget build(BuildContext context) {
    // 主界面   title  &  content
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: color_bg_main,
        child: FaultReportPage(params),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: color_bg_main,
        title: Text(
          MyLocalizations.of(context).getString(trouble_report),
          style: TextStyle(fontSize: sp_title),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
//              FlutterBoost.singleton.closeCurrent();
                Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: color_bg_333333,
            )),
      ),
    );
  }
}

class FaultReportPage extends StatefulWidget {
  final Map params;
  FaultReportPage(this.params);

  @override
  State<StatefulWidget> createState() {
    return new _FaultReportState();
  }
}

class _FaultReportState extends State<FaultReportPage> {
  List problemDescriptionList = [
    {"title": "外壳损坏", "type": 0,},
    {"title": "充电线损坏", "type": 1},
    {"title": "无法充电", "type": 2},
    {"title": "其它", "type": 3},
  ];

  int groupValue = 0;

  List _file_path = [];

  final int MAXSELECTEDIMAGE = 4;

  Map<String, String> uploadImagePaths = Map<String, String>();

  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 20.0, right: 0.0, bottom: 12.0),
            child: new Text(
              MyLocalizations.of(context).getString(device_info),
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: color_text_333333,
                fontSize: sp_16,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max, //有效，外层Colum高度为整个屏幕
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(top: 0, bottom: 0),
                      child: Row(
                        children: <Widget>[
                          new Text(
                            "IMEI",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: color_text_333333,
                              fontSize: sp_14,
                            ),
                          ),
                          Flexible(
                            fit: FlexFit.tight,
                            child: new Text(
                              widget.params["imei"],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: color_text_999999,
                                fontSize: sp_14,
                              ),
                            ),
                          )
                        ],
                      )),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(4.0))
              ),
            ),
          Padding(
            padding:
                EdgeInsets.only(top: 24.0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: "问题描述",
                style: TextStyle(
                    color: color_text_333333,
                    fontSize: sp_16,
                    fontWeight: FontWeight.w700
                ),
              ),
              TextSpan(
                text: " (必填) ",
                style: TextStyle(
                  color: color_text_999999,
                  fontSize: sp_12,
                ),
              ),
            ])),
          ),
          Padding(
            padding:
            EdgeInsets.only(top: 5.0),
            child: Wrap(
              spacing: 8.0, // 主轴(水平)方向间距
              runSpacing: 4.0, // 纵轴（垂直）方向间距
              alignment: WrapAlignment.start,
              children: _typeWidgets(),
            ),
          ),
          Padding(
            padding:
            EdgeInsets.only(top: 8.0),
            child:Container(
              height: 111,
              padding:
              EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
              child: TextField(
                  controller: _textEditingController,
                  maxLines: 4,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      hintText: "", border: InputBorder.none //隐藏下划线
                  )),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(4.0))
              ),
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 0.0, top: 24.0, right: 0.0, bottom: 0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: "上传图片",
                style: TextStyle(
                  color: color_text_333333,
                  fontSize: sp_16,
                    fontWeight: FontWeight.w700
                ),
              ),
              TextSpan(
                text: " (非必填,最多4张) ",
                style: TextStyle(
                  color: color_text_999999,
                  fontSize: sp_12,
                ),
              ),
            ])),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 12),
              child: new GridView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                // ignore: unrelated_type_equality_checks
                itemCount: _file_path.length < MAXSELECTEDIMAGE ? _file_path.length + 1 : _file_path.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.0),
                // ignore: missing_return
                itemBuilder: (BuildContext context, int position) {
                  if (_file_path.length == 0) {
                    return _addImageButton;
                  } else {
                    if (position >= _file_path.length) {
                      return _addImageButton;
                    } else {
                      return selectedImage(position);
                    }
                  }
                },
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: RaisedButton(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      onPressed: () {
                        _submitProblem();
                      },
                      color: color_theme,
                      child: Text(
                        "提交",
                        style: TextStyle(
                            fontSize: sp_16, color: color_text_FFFFFF),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))))),
        ],
      ),
    );
  }

  Future<bool> _uploadImages() async {
    for (Map filePath in _file_path) {
      // 如果已上传过了跳过再次上传
      if (uploadImagePaths.keys.contains(filePath["path"])) {
        break;
      }
      FormData formData = FormData.fromMap({
        "uploadFile": await MultipartFile.fromFile(
            filePath["path"],
            filename: filePath["path"].substring(filePath["path"].lastIndexOf("/") + 1, filePath["path"].length)
        ),
      });
      try {
        Response response = await Dio().post(
            UrlApi.UPLOAD_IMAGE,
            data: formData,
            queryParameters: {
              "orderSn": widget.params['orderSn'],
              "streamNo": NetUtil.getSteamNo(),
              "Accept-Language": MyLocalizations.of(context).getLanguage()
            },
            options: Options(
                headers: {
                  "Accept-Language": MyLocalizations.of(context).getLanguage(),
                },
                contentType: "application/json",
                responseType: ResponseType.json
            ),
            onSendProgress: (count, total) {
              ULog.i("图片 $filePath 上传进度 ====> ${count / total}");
            }
        );
        if (response.data != null && response.data is Map && response.data["resultCode"] == "00000000") {
            if(response.data["data"] != null && response.data["data"]["objectURL"] != null) {
//              objectURL 这个地址是cdn加速后的图片地址，这个国内访问会很快的，国外速度也可以
//              sourceURL 这个是s3的源地址，国内又被屏蔽的风险和以及访问有时候会慢的
//              建议用cdn的地址的，objectURL
              uploadImagePaths[filePath["path"]]= response.data["data"]["objectURL"];
            } else {
              _uploadImageFailureAlert(filePath["path"], _file_path.indexOf(filePath));
              return false;
            }
        } else {
          _uploadImageFailureAlert(filePath["path"], _file_path.indexOf(filePath));
          return false;
        }
      } catch(e) {
        ULog.i(e.toString());
        _uploadImageFailureAlert(filePath["path"], _file_path.indexOf(filePath));
        return false;
      }
    }
    return true;
  }

  _uploadImageFailureAlert(String file, int index) {
    Fluttertoast.showToast(msg: "第$index张图片 $file 上传失败", gravity: ToastGravity.CENTER);
    ULog.i("第$index张图片 $file 上传失败");
  }

  void _submitProblem() async {
    AlertUtil.showNetLoadingDialog(context);
    // 1.上传图片
    bool imagesUploadSuccess = await _uploadImages();
    if (imagesUploadSuccess) {
      // 2.上传问题
      String attachFileUrl = "";
      // ignore: missing_return
      for (String tKey in uploadImagePaths.keys) {
        attachFileUrl += uploadImagePaths[tKey];
        attachFileUrl += ',';
      }
      FaultRepository.faultReport(
          widget.params['imei'],
          problemDescriptionList[groupValue]['title'],
          widget.params['orderSn'],
          attachFileUrl: attachFileUrl,
          success: (any){
            AlertUtil.dismissNetLoading(context);
            Fluttertoast.showToast(msg: "问题提交成功", gravity: ToastGravity.CENTER, toastLength: Toast.LENGTH_LONG);
            Navigator.of(context).pop();
          },
          failure: (error) {
            AlertUtil.dismissNetLoading(context);
            Fluttertoast.showToast(msg: "问题提交失败", gravity: ToastGravity.CENTER);
          },
          problemDesc: _textEditingController.text,
      );
    } else {
      AlertUtil.dismissNetLoading(context);
    }
  }

  Widget get _addImageButton {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color_line, width: 1)),
      child: new Align(
        alignment: Alignment.center,
        child: new GestureDetector(
          onTap: () {
            _showMediaBottomSheet(context);
          },
          child: new Image.asset(
            'images/add_pic.png',
            fit: BoxFit.cover,
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }

  Widget selectedImage(int position) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: color_line, width: 1)),
      height: 60,
      width: 60,
      child: _file_path.length > position
          ? new Stack(
        children: <Widget>[
//          _file_path[position]["type"] == MeidaType.IMAGE
//              ?
          Card(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadiusDirectional
                    .circular(4)),
            clipBehavior: Clip.none,
            child: Image.file(
              new File(
                  _file_path[position]["path"]),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
//              : videoItem(context, _file_path[position]),
          new Align(
            alignment: Alignment.center,
            child: new GestureDetector(
              onTap: () {
                _removeMedia(position);
              },
              child: new Image.asset(
                'images/remove_pic.png',
                fit: BoxFit.cover,
                height: 24,
                width: 24,
              ),
            ),
          ),
        ],
      )
          : new Container(),
    );
  }

  List<Widget> _typeWidgets() {
    return List<Widget>.generate(
      problemDescriptionList.length,
          (int index) {
        return ChoiceChip(
          label: Text(problemDescriptionList[index]['title'], style: TextStyle(fontSize: 12)),
          selected: groupValue == index,
          selectedColor: color_bg_FF5099CC,
          backgroundColor: Colors.white,
          elevation: 0,
          pressElevation: 0,
          materialTapTargetSize: MaterialTapTargetSize.padded,
          padding: EdgeInsets.only(left: 5, right: 5),
          onSelected: (bool selected) {
            setState(() {
              groupValue = index;
            });
          },
        );
      },
    ).toList();
  }

  Widget problemDescriptionListViewItem(context, value) {
    return groupValue == value['type']
        ? Container(
            padding:
                EdgeInsets.only(left: 6.0, top: 0.0, right: 6.0, bottom: 0.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              color: color_bg_FF5099CC,
              onPressed: () {
                updateGroupValue(value['type']);
              },
              child: Text(
                value['title'],
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: sp_12,
                ),
              ),
            ),
          )
        : Container(
            padding:
                EdgeInsets.only(left: 6.0, top: 0.0, right: 6.0, bottom: 0.0),
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              onPressed: () {
                updateGroupValue(value['type']);
              },
              child: Text(
                value['title'],
                maxLines: 1,
                style: TextStyle(
                  color: color_text_333333,
                  fontSize: sp_12,
                ),
              ),
            ),
          );
  }

  void updateGroupValue(int v) {
    setState(() {
      groupValue = v;
    });
  }

  Future _pickImageFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);
      if (_file_path.length < MAXSELECTEDIMAGE) {
        setState(() {
          _file_path.add({"path": image.path, "type": MeidaType.IMAGE});
        });
      } else {
        _showMsg("上传图片,最多4张");
      }
  }

  Future _takePhoto() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);
      if (_file_path.length < MAXSELECTEDIMAGE) {
        setState(() {
          _file_path.add({"path": image.path, "type": MeidaType.IMAGE});
        });
      } else {
        _showMsg("上传图片,最多4张");
      }
  }

  _showMsg(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _removeMedia(int pos) {
    setState(() {
      _file_path.removeAt(pos);
    });
  }

  _showMediaBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 118,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('拍照'),
                  onTap: () {
                    _takePhoto();
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('图片选择'),
                  onTap: () {
                    _pickImageFromGallery();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}

enum MeidaType { IMAGE, VIEDO }

