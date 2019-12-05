import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/call_log/presenter/CallLogHomePresenter.dart';
import 'package:flutter_app/Simbox/common/mvp/BasePageState.dart';
import 'package:flutter_app/Simbox/call_log/widget/CallLogListView.dart';
import '../../widget/CardAppBar.dart';
import '../../widget/CustomKeyBoardView.dart';

class CallLogHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CallLogHomePageState();
}

class CallLogHomePageState extends BasePageState<CallLogHomePage, CallLogHomePresenter> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<CallLogHomePage> {
  AnimationController _controller;
  Animation<Offset> _animation;

  @override
  CallLogHomePresenter createPresenter() => CallLogHomePresenter();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(duration: Duration(milliseconds: 300), vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {}
    });
    _animation = Tween(begin: Offset.zero, end: Offset(0.0, 1.0)).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CardAppBar(),
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Container(
          height: size.height,
          width: size.width,
          child: CallLogListView(),
        ),
        Positioned(
          right: 15.0,
          bottom: 15.0,
          child: ClipOval(
              child: GestureDetector(
                onTap: () {
                  showKeyBoard(true);
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Theme.of(context).primaryColor,
                  alignment: Alignment.center,
                  child: Icon(Icons.keyboard, color: Colors.white),
                ),
              )),
        ),
        SlideTransition(
          position: _animation,
          child: Container(
            child: CustomKeyBoardView(() => showKeyBoard(false), "CallLogHomePage"),
          ),
        ),
      ]),
    );
  }

  void showKeyBoard(bool show) {
    show ? _controller.reverse() : _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
