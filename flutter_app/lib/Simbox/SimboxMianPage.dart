import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/page/CallLogHomePage.dart';
import 'package:flutter_app/Simbox/page/ContactHomePage.dart';
import 'package:flutter_app/Simbox/page/MessageHomePage.dart';
import 'package:flutter_app/Simbox/page/PersonHomePage.dart';

class SimboxMainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SimboxMainPageState();
  }
}

class SimboxMainPageState extends State<SimboxMainPage> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  final children = _children();

  @override
  Widget build(BuildContext context) {
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
    return [
      const BottomNavigationBarItem(title: Padding(padding: EdgeInsets.only(top: 3.0), child: Text('拨号'),), icon: Icon(Icons.call)),
      const BottomNavigationBarItem(title: Padding(padding: EdgeInsets.only(top: 3.0), child: Text('联系人'),), icon: Icon(Icons.contacts)),
      const BottomNavigationBarItem(title: Padding(padding: EdgeInsets.only(top: 3.0), child: Text('短信'),), icon: Icon(Icons.message)),
      const BottomNavigationBarItem(title: Padding(padding: EdgeInsets.only(top: 3.0), child: Text('个人'),), icon: Icon(Icons.person)),];
  }
}