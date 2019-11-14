import 'package:flutter/material.dart';

class ParentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ParentWidgetState();
  }
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
  : super(key: key);
  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  State<StatefulWidget> createState() {
    return _TapboxCState();
  }
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            widget.active ? 'Active' : 'Inactive',
            style: new TextStyle(
              fontSize: 32.0,
              color: Colors.white
            ),
          ),
        ),
        width: 150.0,
        height: 100.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight ? new Border.all(
            color: Colors.teal[700],
            width: 10.0
          ): null
        ),
      ),
    );
  }
}