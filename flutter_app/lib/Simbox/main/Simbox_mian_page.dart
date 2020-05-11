import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/call_log/page/call_log_home_page.dart';
import 'package:flutter_app/Simbox/contact/page/contact_home_page.dart';
import 'package:flutter_app/Simbox/message/message_home_page.dart';
import 'package:flutter_app/Simbox/person/page/person_home_page.dart';
import 'package:flutter_app/Simbox/common/SimboxLocalizations.dart';

class SimboxMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SimboxMainPageState();
  }
}

class SimboxMainPageState extends State<SimboxMainPage> with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<SimboxMainPage>{
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final children = _children();

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: PageView.builder(
          controller: _pageController,
          onPageChanged: _onPageChange,
          itemCount: 4,
          itemBuilder: (context, index) {
            return children[index];
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems(),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 10.0,
        unselectedFontSize: 10.0,
        iconSize: 24.0,
        currentIndex: _currentIndex,
        onTap: _onTapBottomBar,
        elevation: 3.0,
      ),
    );
  }

  void _onTapBottomBar(int index) {
    _pageController.jumpToPage(index);
    _onPageChange(index);
  }

  void _onPageChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  static List<Widget> _children() {
    return [
      CallLogHomePage(),
      ContactHomePage(),
      MessageHomePage(),
      PersonHomePage()
    ];
  }

  List<BottomNavigationBarItem> _bottomNavigationBarItems() {
    List items = List<BottomNavigationBarItem>();
    List<_BottomBarItemModel> datas = [
      _BottomBarItemModel(SimboxLocalizations.of(context).callLog,
          "images/ic_calllog.png", "images/ic_calllog_selected.png"),
      _BottomBarItemModel(SimboxLocalizations.of(context).contact,
          "images/ic_contact.png", "images/ic_contact_selected.png"),
      _BottomBarItemModel(SimboxLocalizations.of(context).message,
          "images/ic_message.png", "images/ic_message_selected.png"),
      _BottomBarItemModel(SimboxLocalizations.of(context).individual,
          "images/ic_individual.png", "images/ic_individual_selected.png"),
    ];
    datas.forEach((data) {
      items.add(BottomNavigationBarItem(
        title: Padding(
          padding: EdgeInsets.only(top: 5.0),
          child: Text(data.title),
        ),
        icon: Image(
          image: AssetImage(data.imagePath),
        ),
        activeIcon: Image(
          image: AssetImage(data.selectedImagePath),
        ),
      ));
    });

    if (items.isEmpty) throw Exception("_bottomNavigationBarItems can't null");

    return items;
  }

  @override
  bool get wantKeepAlive => true;
}

class _BottomBarItemModel {
  String title;
  String imagePath;
  String selectedImagePath;

  _BottomBarItemModel(this.title, this.imagePath, this.selectedImagePath);
}
