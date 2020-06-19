import 'dart:io';

import 'package:core_log/core_log.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_boost/flutter_boost.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:video_player/video_player.dart';

class FaultReporting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 主界面   title  &  content
    return new Scaffold(
      body: FaultReport(),
      appBar: AppBar(
        backgroundColor: color_bg_FFFFFF,
        title: Text(
          MyLocalizations.of(context).getString(trouble_report),
          style: TextStyle(fontSize: sp_title),
        ),
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
//              FlutterBoost.singleton.closeCurrent();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: color_bg_333333,
            )),
      ),
    );
  }
}

class FaultReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _FaultReportState();
  }
}

class _FaultReportState extends State<FaultReport> {
  List problemDescriptionList = [
    {
      "title": "外壳损坏",
      "type": 0,
    },
    {"title": "充电线损坏", "type": 1},
    {"title": "无法充电", "type": 2},
    {"title": "其它", "type": 3},
  ];

  int groupValue = -1;

  List _file_path = [];

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 0.0, top: 20.0, right: 0.0, bottom: 12.0),
            child: new Text(
              MyLocalizations.of(context).getString(device_info),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: TextStyle(
                color: color_text_333333,
                fontSize: sp_16,
              ),
            ),
          ),
          new Container(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
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
                              "61052457963105891644",
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
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 0.0, top: 24.0, right: 0.0, bottom: 0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: "问题描述",
                style: TextStyle(
                  color: color_text_333333,
                  fontSize: sp_16,
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
          Container(
            height: 50.0,
            child: ListView.builder(
                padding: EdgeInsets.only(
                    left: 0.0, top: 12.0, right: 0.0, bottom: 12.0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: problemDescriptionList.length,
                itemBuilder: (BuildContext context, int index) {
                  return problemDescriptionListViewItem(
                      context, problemDescriptionList[index]);
                }),
          ),
          Container(
            height: 111,
            color: Colors.white,
            padding:
                EdgeInsets.only(left: 16.0, top: 0.0, right: 16.0, bottom: 0.0),
            child: TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "", border: InputBorder.none //隐藏下划线
                    )),
          ),
          Padding(
            padding:
                EdgeInsets.only(left: 0.0, top: 24.0, right: 0.0, bottom: 0),
            child: Text.rich(TextSpan(children: [
              TextSpan(
                text: "上传图片/视频",
                style: TextStyle(
                  color: color_text_333333,
                  fontSize: sp_16,
                ),
              ),
              TextSpan(
                text: " (非必填，不超过10MB) ",
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
                // ignore: unrelated_type_equality_checks
                itemCount: _file_path.length >= 9 ? 9 : _file_path.length + 1,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.0),
                // ignore: missing_return
                itemBuilder: (BuildContext context, int position) {
                  if (position == _file_path.length) {
                    return new Container(
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
                  } else {
                    return new Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: color_line, width: 1)),
                      height: 60,
                      width: 60,
                      child: _file_path.length > position
                          ? new Stack(
                              children: <Widget>[
                                _file_path[position]["type"] == MeidaType.IMAGE
                                    ? /*new Image.file(
                                        new File(_file_path[position]["path"]),
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      )*/
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
                                      )
                                    : videoItem(context, _file_path[position]),
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
                },
              ),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 20, bottom: 5),
              child: SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: RaisedButton(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      onPressed: () {},
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

  Widget videoItem(context, value) {
    return VideoPlayerScreen(value["path"]);
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
    int size = await image.length();
    if (size > 10 * 1024 * 1024) {
      _showMsg("上传图片/视频(非必填，不超过10MB)");
    } else {
      setState(() {
        _file_path.add({"path": image.path, "type": MeidaType.IMAGE});
      });
    }
  }

  Future _pickVideo() async {
    File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    int size = await video.length();
    ULog.e("file:" + video.path + " size:" + size.toString());
    if (size > 10 * 1024 * 1024) {
      _showMsg("上传图片/视频(非必填，不超过10MB)");
    } else {
      setState(() {
        _file_path.add({"path": video.path, "type": MeidaType.VIEDO});
      });
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
                  title: Text('图片选择'),
                  onTap: () {
                    print('图片选择');
                    _pickImageFromGallery();
                    Navigator.pop(context, "图片选择");
                  },
                ),
                ListTile(
                  title: Text('视频选择'),
                  onTap: () {
                    print('视频选择');
                    _pickVideo();
                  },
                ),
              ],
            ),
          );
        });
  }
}

enum MeidaType { IMAGE, VIEDO }

class VideoPlayerScreen extends StatefulWidget {
  String path;

  VideoPlayerScreen(String path) {
    this.path = path;
  }

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState(path);
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  String path;

  _VideoPlayerScreenState(String path) {
    this.path = path;
  }

  @override
  void initState() {
    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    _controller = VideoPlayerController.file(File(this.path));

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Center(
      child: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Butterfly Video'),
      ),*/
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the VideoPlayerController has finished initialization, use
            // the data it provides to limit the aspect ratio of the video.
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              // Use the VideoPlayer widget to display the video.
              child: VideoPlayer(_controller),
            );
          } else {
            // If the VideoPlayerController is still initializing, show a
            // loading spinner.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              // If the video is paused, play it.
              _controller.play();
            }
          });
        },
        // Display the correct icon depending on the state of the player.
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),*/ // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
