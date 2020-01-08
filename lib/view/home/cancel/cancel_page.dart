import 'package:driver_app/view/detail/detail_page.dart';
import 'package:flutter/material.dart';
import '../order_model.dart';

class CancelPage extends StatelessWidget {
  const CancelPage({ Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Order> order = new List();
    order.add(Order("1", "196, Cancel, NDC", "Clother", "0999999999","14:00"));
    order.add(Order("2", "196, Cancel, NDC", "Computer", "0999799989","17:28"));
    order.add(Order("3", "196, Cancel, NDC", "Glass", "0999999999","07:26"));
    order.add(Order("4", "196, Cancel, NDC", "Phone", "0993929992","14:26"));
    order.add(Order("5", "196, Cancel, NDC", "Shoes", "0999999999","19:33"));
    order.add(Order("6", "196, Cancel, NDC", "Domain", "0999956999","14:26"));
    order.add(Order("7", "196, Cancel, NDC", "Building materials", "0999999999","14:51"));
    order.add(Order("8", "196, Cancel, NDC", "Helmet", "0993299659","14:50"));
    order.add(Order("9", "196, Cancel, NDC", "Flower", "0999922999","14:00"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel"),
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.black12,
      body: SizedBox.expand(
        child: ListView.builder(
          itemCount: order.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              child: Card(
                color: Colors.black12.withOpacity(0.25),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(order: order[index]),
                      ),
                    );
                  },
                  child: Column(
                      children: <Widget> [
                        Text(order[index].id, style: Theme.of(context).primaryTextTheme.body1),
                        Text(order[index].name, style: Theme.of(context).primaryTextTheme.body1),
                        Text(order[index].address, style: Theme.of(context).primaryTextTheme.body1),
                      ]
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
