import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TapboxA extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TapboxAState();
  }
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(
              fontSize: 22.0,
              color: Colors.white
            ),
          ),
        ),
        width: 150.0,
        height: 100.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600]
        ),
      ),
    );
  }
}