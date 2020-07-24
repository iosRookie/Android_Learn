import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:core_log/core_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as MFLocation;
import 'package:mifi_rental/common/preference_key.dart';
import 'package:mifi_rental/common/route.dart';
import 'package:mifi_rental/dialog/privacy_policy.dart';
import 'package:mifi_rental/dialog/tips_dialog.dart';
import 'package:mifi_rental/entity/terminal_site.dart';
import 'package:mifi_rental/localizations/localizations.dart';
import 'package:mifi_rental/page/rent/rent_provider.dart';
import 'package:mifi_rental/repository/terminal_repository.dart';
import 'package:mifi_rental/res/colors.dart';
import 'package:mifi_rental/res/dimens.dart';
import 'package:mifi_rental/res/strings.dart';
import 'package:mifi_rental/util/connect_util.dart';
import 'package:mifi_rental/util/shared_preferences_util.dart';
import 'package:permission_handler/permission_handler.dart';

class RentPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RentPageState();
  }
}

class RentPageState extends State<RentPage>  with AutomaticKeepAliveClientMixin {
   var _selectedIndex = 0;
   List<TerminalSite> _sites = [];
   GoogleMap _map;
   GoogleMapController _controller;
   static Map<MarkerId, Marker> _markers = <MarkerId, Marker>{};
   MarkerId selectedMarker;
   RentProvider _rentProvider;
   PageController pageController = PageController();

   static CameraPosition _usePlex = CameraPosition(
    target: LatLng(39.91667, 116.41667),
    zoom: 11,
  );

   @override
   bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _rentProvider = RentProvider();
    _rentProvider.context = context;

    currentLocation().then((value) {
      // 获取附近站点
      TerminalRepository.queryTerminalSites(value["currentLng"].toString(), value["currentLat"].toString(), (sites){
        var tempList = List<TerminalSite>();
        if (sites != null) {
          sites.forEach((value) {
            if (value is TerminalSite) {
              tempList.add(value);
            }
          });
          _addMarkers(tempList);
        }
      }, (error) {

      });
    }, onError: (error) {

    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _appbar(),
      body: _body()
    );
  }

  PreferredSizeWidget _appbar() {
    return AppBar(
      brightness: Brightness.light,
      backgroundColor: Colors.white,
      elevation: 0,
      title: segmentBar(),
//      Text(
//        MyLocalizations.of(context).getString(home_page),
//        style: TextStyle(fontSize: sp_title),
//      ),
      centerTitle: true,
      actions: <Widget>[
        PopupMenuButton(
          icon: Icon(
            Icons.more_horiz,
            color: color_bg_333333,
          ),
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
            PopupMenuItem<String>(
              child: Center(
                child: Text(
                  MyLocalizations.of(context).getString(user_agreement),
                  style: TextStyle(fontSize: sp_14, color: color_text_333333),
                ),
              ),
              value: 'userAgreement',
            ),
            PopupMenuItem<String>(
              child: Center(
                child: Text(
                  MyLocalizations.of(context).getString(privacy_policy),
                  style: TextStyle(fontSize: sp_14, color: color_text_333333),
                ),
              ),
              value: 'privacyPolicy',
            ),
          ],
          onSelected: (String action) {
            switch (action) {
              case 'userAgreement':
                _showUserAgreement(context);
                break;
              case 'privacyPolicy':
                CustomBottomSheetDialog.show(context, BottomSheetType.privacy_policy);
                break;
            }
          },
        ),
      ],
    );
  }

  Widget segmentBar() {
    return ClipRRect(
      borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0), right: Radius.circular(15.0)),
      child: Container(
        height: 30.0,
        width: 200.0,
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: FlatButton(
                color: _selectedIndex == 0 ? color_theme : Colors.white,
                child: Text("地图", style: TextStyle(
                    fontSize: 14,
                    color: _selectedIndex == 0 ? Colors.white : Colors.grey
                ),),
                shape: _selectedIndex == 0 ? RoundedRectangleBorder() : RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 0.5, style: BorderStyle.solid),
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(15.0))
                ),
                onPressed: () {
                    setState(() {
                        _selectedIndex = 0;
                        pageController.animateToPage(_selectedIndex, duration: Duration(milliseconds: 300), curve: Curves.linear);
                    });
                },
              ),
            ),
            Expanded(
              flex: 1,
              child: FlatButton(
                color: _selectedIndex == 1 ? color_theme : Colors.white,
                child: Text("列表", style: TextStyle(
                    fontSize: 14,
                    color: _selectedIndex == 1 ? Colors.white : Colors.grey
                ),),
                shape: _selectedIndex == 1 ? RoundedRectangleBorder() : RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey, width: 0.5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(15.0))
                ),
                onPressed: () {
                  setState(() {
                      _selectedIndex = 1;
                      pageController.animateToPage(_selectedIndex, duration: Duration(milliseconds: 300), curve: Curves.linear);
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  _showUserAgreement(BuildContext context) async {
    bool agree = await SharedPreferenceUtil.getBool(USER_AGREEMENT) ?? false;
//    UserAgreementDialog().show(context, showActions: !agree);
    CustomBottomSheetDialog.show(context, BottomSheetType.user_agreement, showActions: !agree);
  }

  Widget _body() {
      _map = GoogleMap(
          initialCameraPosition: _usePlex,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: Set<Marker>.of(_markers.values)
      );
    return Container(
        color: color_bg_F5F5F5,
        child: Column(
          children: <Widget>[
            Expanded(
                child: PageView.builder(
                    controller: pageController,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                  if (index == 0) {
                    return  _map;
                  } else {
                    return Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
                      child: _sites.length > 0 ?
                      ListView.separated(itemBuilder: (context, index) {
                        return ListItemView(_sites[index]);
                      }, separatorBuilder: (context, index) {
                        return Container(color: Colors.transparent, height: 8.0);
                      }, itemCount: _sites.length) :
                      Center(child: Text("附近暂无可用终端")),
                    );
                  }
                })
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              height: 200.0,
              child: Stack(
                children: <Widget>[
                  Positioned(
                      top: dp_frame,
                      left: dp_frame,
                      child: Material(
                          color: Colors.transparent,
                          child: Ink(
                            decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage('images/faq.png'))),
                            child: InkWell(
                              borderRadius: new BorderRadius.circular(40.0),
                              onTap: () {
                                Navigator.of(context).pushNamed(PROBLEM);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                              ),
                            ),
                          ))),
                  Center(child: Padding(
                    padding: EdgeInsets.only(top: 28),
                    child: _Scan(),
                  ))
                ],
              ),
            )
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
        ));
  }

  Future<Map<String, double>> currentLocation() async {
    Map<String, double> defaultLocal = {"currentLng": 116.41667, "currentLat": 39.91667};
    MFLocation.Location location = new MFLocation.Location();
    MFLocation.PermissionStatus hasLocationPermission = await location.hasPermission();
    if (hasLocationPermission == MFLocation.PermissionStatus.granted) {
      // 获取地理位置
      MFLocation.LocationData locationData = await location.getLocation();
//      _usePlex = CameraPosition(
//          target: LatLng(locationData.latitude, locationData.longitude),
//          zoom: 11
//      );
//      await _gotoCurrentPosition(_usePlex);
      setState(() {
        _usePlex = CameraPosition(
            target: LatLng(locationData.latitude, locationData.longitude),
            zoom: 11
        );
      });
      defaultLocal = {"currentLng": locationData.longitude, "currentLat": locationData.latitude};
    } else {
      ULog.i("没有位置权限, 使用默认北京位置");
      hasLocationPermission = await location.requestPermission();
      if (hasLocationPermission == MFLocation.PermissionStatus.granted) {
        MFLocation.LocationData locationData = await location.getLocation();

        setState(() {
          _usePlex = CameraPosition(
              target: LatLng(locationData.latitude, locationData.longitude),
              zoom: 11
          );
        });
//        await _gotoCurrentPosition(_usePlex);
        defaultLocal = {"currentLng": locationData.longitude, "currentLat": locationData.latitude};
      }
    }
    return defaultLocal;
  }

  Future<void> _gotoCurrentPosition(CameraPosition position) async {
    _controller.animateCamera(CameraUpdate.newCameraPosition(position));
  }

  void _addMarkers(List<TerminalSite> sites) {
     if (sites == null || sites.length == 0) {
       return;
     }
     int markerIdCounter = 0;
     Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
     sites.forEach((site) {
       final String markerIdVal = 'marker_id_$markerIdCounter';
       final MarkerId markerId = MarkerId(markerIdVal);
       final Marker marker = Marker(
           markerId: markerId,
           position: LatLng(site.bankLat, site.bankLng),
           infoWindow: InfoWindow(title: site.bankName, snippet: site.address),
           onTap: () {
             _onMarkerTapped(markerId);
           }
       );
       markers[markerId] = marker;
       markerIdCounter ++;
     });

     setState(() {
       _markers = markers;
       _sites = sites;
     });
  }

  void _removeMark() {
     setState(() {
       if (_markers.containsKey(selectedMarker)) {
         _markers.remove(selectedMarker);
       }
     });
  }

  void _onMarkerTapped(MarkerId markerId) {
     final Marker tappedMarker = _markers[markerId];
     if (tappedMarker != null) {
       setState(() {
         if (_markers.containsKey(selectedMarker)) {
           final Marker resetOld = _markers[selectedMarker].copyWith(
             iconParam: BitmapDescriptor.defaultMarker
           );
           _markers[selectedMarker] = resetOld;
         }
         selectedMarker = markerId;
         final Marker newMarker = tappedMarker.copyWith(
           iconParam: BitmapDescriptor.defaultMarkerWithHue(
             BitmapDescriptor.hueGreen
           )
         );
         _markers[markerId] = newMarker;
       });
     }
  }
}


class _Scan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Material(
            color: color_bg_FFFFFF,
            child: Ink(
                decoration: BoxDecoration(
                  color: color_theme, // 背景色
                  shape: BoxShape.circle,
                ),
                child: InkWell(
                  borderRadius: new BorderRadius.circular(50.0),
                  onTap: () {
                    _scan(context);
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('images/scan.png', width: 28, height: 28,),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            MyLocalizations.of(context).getString(scan),
                            style: TextStyle(
                                color: color_text_FFFFFF, fontSize: sp_12),
                          ),
                        )
                      ],
                    ),
                  ),
                ))),
        Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: Text(
            MyLocalizations.of(context).getString(scan_wifi_rental),
            style: TextStyle(color: color_text_333333, fontSize: sp_12),
          ),
        )
      ],
    );
  }

  _scan(BuildContext context) async {
    bool agree = await SharedPreferenceUtil.getBool(USER_AGREEMENT) ?? false;
    if (!agree) {
      CustomBottomSheetDialog.show(context, BottomSheetType.user_agreement, showActions: !agree);
    } else {
      ConnectUtil.isConnected().then((b) {
        if (!b) {
          TipsDialog().show(context,
              MyLocalizations.of(context).getString(network_exceptions));
          return;
        }
        _doScan(context);
      });
    }
  }

  void _doScan(BuildContext context) async {
    try {
      ScanResult result = await BarcodeScanner.scan();
//      Navigator.of(context).pushNamed(PAY, arguments: '88000004');
      // 开发环境
      if (result.type == ResultType.Barcode) {
        if (result.rawContent.contains('rental.ukelink.net')) {
          try {
            var sn = result.rawContent.substring(result.rawContent.indexOf('=') + 1, result.rawContent.length);
            ULog.i('扫码设备sn: $sn');
            Navigator.of(context).pushNamed(PAY, arguments: sn);
          } catch (e) {
            ULog.e(e.toString());
          }
        }
      }
    } on PlatformException catch (e) {} on FormatException {} catch (e) {}
  }

  Future<bool> requestPermissions() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([
      PermissionGroup.camera,
    ]);
    return permissions[PermissionGroup.camera] == PermissionStatus.granted;
  }
}

class ListItemView extends StatefulWidget {
  final TerminalSite model;
  ListItemView(this.model);

  @override
  State<StatefulWidget> createState() {
    return ListItemState();
  }
}

class ListItemState extends State<ListItemView> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
      child: Container(
        color: Colors.white,
        height: 94,
        child: Stack(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(left: 16.0, top: 14.0, right: 87.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(widget.model.bankName,
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 16.0, color: color_bg_333333, fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 4.0),
                      child: Text(widget.model.address,
                        style: TextStyle(fontSize: 14.0, color: color_text_666666),
                        maxLines: 2,),
                    ),
                  ],
                )
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: 77.0,
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Container(
                        color: color_text_E0E0E0,
                        width: 0.5,
                      ),
                    ),
                    Container(
                      alignment: AlignmentDirectional.center,
                      width: 76.5,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset('images/navigation.png'),
                            Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text('1.2km', style: TextStyle(fontSize: 12, color: color_text_666666),),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
