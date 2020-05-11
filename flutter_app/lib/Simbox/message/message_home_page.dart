import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class MessageHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessageHomePageState();
  }
}

class MessageHomePageState extends State<MessageHomePage> with AutomaticKeepAliveClientMixin<MessageHomePage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('短信', style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        child: IconButton(icon: Icon(Icons.scanner, color: Color.fromARGB(255, 255, 0, 0)), onPressed: (){
            _scan();
        }),
      ),
    );
  }

  _scan() async {
    try {
      ScanResult result = await BarcodeScanner.scan();
      print('');
    } on PlatformException catch (e) {

    } on FormatException{

    } catch (e) {

    }
  }
}