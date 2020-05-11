import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/common/mvp/base_page_state.dart';
import 'package:flutter_app/Simbox/contact/presenter/import_contact_presenter.dart';
import 'package:flutter_app/Simbox/res/colors.dart';
import 'package:flutter_app/Simbox/routes/fluro_navigator.dart';

class ImportContactsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ImportContactsPageState();
}

class ImportContactsPageState
    extends BasePageState<ImportContactsPage, ImportContactPresenter> {
  List<Contact> contacts = [];
  Map<int, bool> selected = Map();

  @override
  ImportContactPresenter createPresenter() => ImportContactPresenter();

  @override
  void initState() {
    super.initState();

    presenter?.readSystemContacts((success, contacts) {
      setState(() {
        this.contacts = contacts;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("导入联系人", style: TextStyle(color: Colors.white)),
          centerTitle: true,
        ),
//      body: IndexListView(itemBuilder: (context, index) {
//
//      }, sectionBuilder: (context, index) {
//
//      }
//      )

        body: Column(
          children: <Widget>[
            Expanded(
            child: ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return _listItem(contacts[index], index);
              })
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.only(left: 30)),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(left: 30, right: 30),
                      height: 44,
                      child: Text("确定", style: TextStyle(color: Colors.white, fontSize: 16.0)),
                      decoration: BoxDecoration(
                        color: SColors.theme_color,
                        borderRadius: new BorderRadius.circular(5.0),
                      ),
                    ),
                    onTap: () {
                      NavigatorUtils.popResult(context, _selectedFinish());
                    },
                  ),
                ),
                Padding(padding: EdgeInsets.only(right: 30)),
              ],
            ),
            Padding(padding: EdgeInsets.only(bottom: 10))
          ]
        )
//            child: Stack(
//              children: <Widget>[
//                _contentList(),
//                _indexView(),
//                _indexAlertView()
//              ],
//            ),
//          )
//          IconButton(icon: Icon(Icons.contacts, size: 80, color: SColors.theme_color,),
//              onPressed: () {
//            _openAddressBook();
//          }
        );
  }

  Widget _listItem(Contact contact, int index) {
    String phone = "";
    contact.phones.forEach((item) {
      phone += item.value;
      phone += " ";
    });
    return Container(
      color: Colors.white,
      height: 60.0,
      child: Row(
        children: <Widget>[
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 15.0, top: 10.0),
                    child: Text(
                      contact.displayName,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      textAlign: TextAlign.left,
                    )),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(left: 15.0, top: 5.0),
                    child: Text(phone,
                        style: TextStyle(color: Colors.grey, fontSize: 12))),
              ),
              Container(
                color: SColors.divider_color,
                height: 0.5,
              )
            ],
          ),),
          Checkbox(
            value: _checkSelected(index),
            checkColor: SColors.theme_color,
            hoverColor: Colors.transparent,
            activeColor: Colors.transparent,
            focusColor: Colors.transparent,
            onChanged: (value) {
              setState(() {
                selected[index] = value;
              });
            },
          )
        ],
      )
    );
//    return ListTile(
//      title: Text(contact.displayName, style: TextStyle(color: Colors.black, fontSize: 16)),
//      subtitle: Text(contact.phones.first.value, style: TextStyle(color: Colors.grey, fontSize: 12)),
//    );
  }

  bool _checkSelected(int index) {
    if (selected.containsKey(index)) {
      return selected[index];
    } else {
      return false;
    }
  }

  List<Contact> _selectedFinish() {
    if (selected.isNotEmpty) {
      List<Contact> selectedContacts = [];
      selected.forEach((index, sel) {
        selectedContacts.add(contacts[index]);
      });
      return selectedContacts;
    } else {
      return [];
    }
  }

  Widget _contentList() {
    return Container(color: Colors.green);
  }

  Widget _indexView() {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(width: 30, color: Colors.blue));
  }

  Widget _indexAlertView() {
    return Align(
        alignment: Alignment.center,
        child: Card(
          color: Colors.black54,
          child: Container(
            alignment: Alignment.center,
            width: 80.0,
            height: 80.0,
            child: Text(
              'title',
              style: TextStyle(
                fontSize: 32.0,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }
}
