import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CounterDisplay extends StatelessWidget {
  CounterDisplay({this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return new Text('Count: $count');
  }
}

class CounterIncrementor extends StatelessWidget {
  CounterIncrementor({this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RaisedButton(
        onPressed: null,
        child: new Text('Increment'),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _CounterState();
  }
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new RaisedButton(
            onPressed: _increment,
            child: new Text('Increment'),
        ),
        new Text('Count: $_counter')
      ],
    );
  }
}