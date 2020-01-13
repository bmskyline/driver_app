import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ScanPageState();
  }
}

class _ScanPageState extends State<ScanPage>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Scan"),
      ),
      body: Text("scan screen"),
    );
  }
}