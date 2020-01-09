import 'package:driver_app/data/model/user_model.dart';
import 'package:driver_app/view/detail/detail_page.dart';
import 'package:flutter/material.dart';
import '../order_model.dart';

class SuccessPage extends StatelessWidget {
  final BuildContext homeContext;
  SuccessPage(this.homeContext, { Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<User> users = new List();/*
    users.add(User(1, "196, Success, NDC", "Clother", "0999999999","14:00"));
    users.add(User(2, "196, Success, NDC", "Computer", "0999799989","17:28"));
    users.add(User(3, "196, Success, NDC", "Glass", "0999999999","07:26"));
    users.add(User(4, "196, Success, NDC", "Phone", "0993929992","14:26"));
    users.add(User(5, "196, Success, NDC", "Shoes", "0999999999","19:33"));
    users.add(User(6, "196, Success, NDC", "Domain", "0999956999","14:26"));
    users.add(User(7, "196, Success, NDC", "Building materials", "0999999999","14:51"));
    users.add(User(8, "196, Success, NDC", "Helmet", "0993299659","14:50"));
    users.add(User(9, "196, Success, NDC", "Flower", "0999922999","14:00"));*/

    return Scaffold(
      appBar: AppBar(
        title: Text("Success"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black12,
      body: SizedBox.expand(
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
              child: Card(
                color: Colors.black12.withOpacity(0.25),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(user: users[index]),
                      ),
                    );
                  },
                  child: Column(
                      children: <Widget> [
                        Text(users[index].id.toString(), style: Theme.of(context).primaryTextTheme.body1),
                        Text(users[index].title, style: Theme.of(context).primaryTextTheme.body1),
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
