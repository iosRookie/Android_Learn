import 'package:flutter/material.dart';
import 'common/CardAppBar.dart';
import 'common/CustomKeyBoardView.dart';

class CallLogHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CallLogHomePageState();
}

class _CallLogHomePageState extends State<CallLogHomePage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(milliseconds: 2000), vsync: this);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //AnimationStatus.completed 动画在结束时停止的状态
        debugPrint('完成');
//        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //AnimationStatus.dismissed 表示动画在开始时就停止的状态
        debugPrint('消失');
//        controller.forward();
//        controller.dispose();
      }
    });
    animation =
        Tween(begin: Offset.zero, end: Offset(0.0, 1.0)).animate(controller);
    //开始执行动画
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var keyboardView = CustomKeyBoardView();

    return Scaffold(
      appBar: CardAppBar(),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: size.height,
            width: size.width,
            color: Colors.red,
            child: Text("content"),
          ),
          SlideTransition(
            position: animation,
            child: Container(
              child: keyboardView,
            ),
          ),
            ]),

      floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          tooltip: 'Add',
          child: new Icon(Icons.keyboard),
          onPressed: () {
            _showKeyBoard(true);
          }
      ),
    );
  }

  void _showKeyBoard(bool show) {

  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}