import 'package:flutter/material.dart';
import 'package:mifi_rental/dialog/loading.dart';

class LoadingPageUtil extends StatelessWidget {
  final bool loading;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset offset;
  final bool barrierDismissible;
  final Widget child;

  LoadingPageUtil({
    Key key,
    @required this.loading,
    this.opacity = 0.5,
    this.color = Colors.black,
    this.progressIndicator = const LoadingDialog(text: "loading"),
    this.offset,
    this.barrierDismissible = false,
    @required this.child,
  }) : assert(child != null),
       assert(loading != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);

    if (loading) {    // 加载中
       Widget layoutProgressIndicator;
       if (offset == null) {
         layoutProgressIndicator = Center(child: progressIndicator);
       } else {
         layoutProgressIndicator = Positioned(
           child: progressIndicator,
           left: offset.dx,
           top: offset.dy,
         );
       }
       final modal = [
         Opacity(
             opacity: opacity,
           child: ModalBarrier(
             dismissible: barrierDismissible,
             color: color,
           ),
         ),
         layoutProgressIndicator
       ];
       widgetList += modal;
    }
    return Stack( children: widgetList );
  }

}