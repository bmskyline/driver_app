import 'package:driver_app/view/home/destination_model.dart';
import 'package:driver_app/view/home/order_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  final Order order;
  const DetailPage({ Key key, this.order }) : super(key: key);


  @override
  _DetailPageState createState() => _DetailPageState(order);
}

class _DetailPageState extends State<DetailPage> {
  final Order order;
  _DetailPageState(this.order);


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail"),
        backgroundColor: Colors.blue
      ),
      backgroundColor: Colors.black12,
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(32.0),
        alignment: Alignment.center,
        child: Text(order.id+ "  "+order.name+ "  "+order.address),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
