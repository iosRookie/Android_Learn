import 'package:flutter/material.dart';
import 'package:flutter_app/Simbox/res/colors.dart';

class IndexListView extends StatefulWidget {
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder sectionBuilder;
  final List<String> sectionsTitle;
  final Map<int, int> rowInSection;

  IndexListView({@required this.itemBuilder, @required this.sectionBuilder, this.sectionsTitle, this.rowInSection});

  @override
  State<StatefulWidget> createState() => _IndexListViewState();
}

class _IndexListViewState extends State<IndexListView> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Stack(
        children: <Widget>[
          _contentList(),
          _indexView(),
          _indexAlertView()
        ],
      ),
    );
  }

  Widget _contentList() {
    return ListView.builder(
        itemBuilder: widget.itemBuilder
    );
  }

  Widget _indexView() {

  }

  Widget _indexAlertView() {

  }

  int _getRowInList() {
    int count = 0;
    widget.rowInSection.forEach((section, rows) {
      count += rows + 1;
    });
    return count;
  }
}