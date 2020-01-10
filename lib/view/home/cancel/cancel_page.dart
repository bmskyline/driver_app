import 'package:driver_app/data/model/user_model.dart';
import 'package:driver_app/view/detail/detail_page.dart';
import 'package:flutter/material.dart';

class CancelPage extends StatefulWidget {
  final BuildContext homeContext;
  CancelPage(this.homeContext, {Key key}) : super(key: key);

  @override
  _CancelStale createState() => _CancelStale(homeContext);
}

class _CancelStale extends State<CancelPage> {
  BuildContext homeContext;
  _CancelStale(this.homeContext);

  @override
  Widget build(BuildContext context) {
    List<User> users = new List();
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));
    users.add(User(9, 1, "196, Cancel, NDC"));

    return Scaffold(
      appBar: AppBar(
        title: Text("Cancel"),
        backgroundColor: Colors.red,
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
                      homeContext,
                      MaterialPageRoute(
                        builder: (context) => DetailPage(user: users[index]),
                      ),
                    );
                  },
                  child: Column(children: <Widget>[
                    Text(users[index].id.toString(),
                        style: Theme.of(context).primaryTextTheme.body1),
                    Text(users[index].title,
                        style: Theme.of(context).primaryTextTheme.body1),
                  ]),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
