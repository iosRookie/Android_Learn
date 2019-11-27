import 'package:flutter/material.dart';
import 'common/CardAppBar.dart';
import 'common/CustomKeyBoardView.dart';

class CallLogHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CallLogHomePageState();
}

class _CallLogHomePageState extends State<CallLogHomePage> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Offset> _animation;

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: CardAppBar(),
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Container(
          height: size.height,
          width: size.width,
          color: Colors.red,
          child: Text("content"),
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
