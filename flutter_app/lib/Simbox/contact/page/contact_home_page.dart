import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/common/widget/CardInfoBar.dart';
import 'package:flutter_app/Simbox/contact/contact_router.dart';
import 'package:flutter_app/Simbox/routes/fluro_navigator.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactHomePageState();
  }
}

class ContactHomePageState extends State<ContactHomePage> with AutomaticKeepAliveClientMixin<ContactHomePage> {

  List<Contact> disContacts = [];

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('联系人', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: <Widget>[
          CardInfoBar(importContacts: () {
            _importSysContactsPage();
          },
          ),
          Expanded(
            child: ListView.builder(
                itemCount: disContacts.length,
                itemBuilder: (context, index) {
                  String phone = "";
                  disContacts[index].phones.forEach((item) {
                    phone += item.value;
                    phone += " ";
                  });
                  return ListTile(
                    title: Text(
                      disContacts[index].displayName,
                      style: TextStyle(color: Colors.black, fontSize: 16)
                    ),
                    subtitle: Text(phone,
                        style: TextStyle(color: Colors.grey, fontSize: 12)
                    ),
                  );
                }
            ),
          )
        ],
      )
    );
  }

  refreshSelectedContacts(List<Contact> selectedContacts) {
    setState(() {
      disContacts = selectedContacts;
    });
  }

  _importSysContactsPage() async{
    PermissionStatus permissionStatus = await PermissionHandler().checkPermissionStatus(PermissionGroup.contacts);
    if (permissionStatus == PermissionStatus.granted) {
      NavigatorUtils.pushResult(context, ContactRouter.importContacts, (object) {
        if (object is List<Contact>) {
          refreshSelectedContacts(object);
        }
      });
    } else if (permissionStatus == PermissionStatus.unknown) {
      Map<PermissionGroup, PermissionStatus> permissions = await PermissionHandler().requestPermissions([PermissionGroup.contacts]);
    } else {
      bool isOpened = await PermissionHandler().openAppSettings();
    }
  }

}