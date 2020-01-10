import 'package:barcode_scan/barcode_scan.dart';
import 'package:driver_app/data/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DetailPage extends StatefulWidget {
  final User user;
  const DetailPage({Key key, this.user}) : super(key: key);

  @override
  _DetailPageState createState() => new _DetailPageState(user);
}

class _DetailPageState extends State<DetailPage> {
  final User user;
  _DetailPageState(this.user);

  /* @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        backgroundColor: Colors.blue
      ),
      backgroundColor: Colors.black12,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.bottomCenter,
        child: Text(user.id.toString()+ "\n"+user.title),
      ),
    );
  }*/

  String result = "Hey there !";

  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("QR Scanner"),
      ),
      body: Center(
        child: Text(
          result,
          style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: _scanQR,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
