import 'package:flutter/material.dart';

class LayoutDome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: Scaffold(
            body: ListView(
              children: <Widget>[
                Image.asset(
                  'images/lake.jpeg',
                  fit: BoxFit.cover,
                ),
                _titleSection(),
                _buttonSection(context),
                _textSection()
              ],
            )));
  }

  Widget _titleSection() {
    return Container(
        padding: EdgeInsets.fromLTRB(32, 15, 32, 15),
        color: Colors.red,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Oeschinen Lake Campground',
                    style: new TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Kandersteg, Switzerland',
                      style: new TextStyle(
                        color: Colors.grey[500],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Icon(Icons.star, color: Colors.yellow),
            Text('41')
          ],
        ));
  }

  Widget _buttonSection(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        color: Colors.green,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _button(Icons.call, 'CALL', context),
            _button(Icons.near_me, 'ROUTE', context),
            _button(Icons.share, 'SHARE', context)
          ],
        ));
  }

  Widget _button(IconData icon, String label, BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(icon, color: color),
        Container(
          margin: EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
          ),
        )
      ],
    );
  }

  Widget _textSection() {
    return Container(
      color: Colors.purple,
      padding: const EdgeInsets.all(32.0),
      child: new Text(
        '''
Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese Alps. Situated 1,578 meters above sea level, it is one of the larger Alpine Lakes. A gondola ride from Kandersteg, followed by a half-hour walk through pastures and pine forest, leads you to the lake, which warms to 20 degrees Celsius in the summer. Activities enjoyed here include rowing, and riding the summer toboggan run.
        ''',
        softWrap: true,
      ),
    );
  }
}
