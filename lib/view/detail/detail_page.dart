import 'package:driver_app/data/model/user_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final Shop user;
  const DetailPage({Key key, this.user}) : super(key: key);

  @override
  _DetailPageState createState() => new _DetailPageState(user);
}

class _DetailPageState extends State<DetailPage> {
  final Shop user;
  _DetailPageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
      ),
      body: Text("scan screen"),
    );
  }
}
