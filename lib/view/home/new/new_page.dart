import 'dart:convert';

import 'package:driver_app/base/base.dart';
import 'package:driver_app/data/model/user_model.dart';
import 'package:driver_app/utils/toast_utils.dart';
import 'package:driver_app/utils/widget_utils.dart';
import 'package:driver_app/view/detail/detail_page.dart';
import 'package:driver_app/view/home/home_page.dart';
import 'package:driver_app/view/home/new/new_provider.dart';
import 'package:flutter/material.dart';
import '../order_model.dart';

class NewPage extends PageProvideNode<NewProvider> {
  final BuildContext homeContext;
  NewPage(this.homeContext);

  @override
  Widget buildContent(BuildContext context) {
    return _NewContentPage(mProvider, homeContext);
  }
}

class _NewContentPage extends StatefulWidget {
  final NewProvider provider;
  final BuildContext homeContext;
  _NewContentPage(this.provider, this.homeContext);

  @override
  State<StatefulWidget> createState() {
    return _NewContentState(homeContext);
  }
}

class _NewContentState extends State<_NewContentPage>
      with TickerProviderStateMixin<_NewContentPage>
      implements Presenter{
  BuildContext homeContext;

  _NewContentState(this.homeContext);

  NewProvider mProvider;
  List<User> users = new List();

  @override
  void initState() {
    super.initState();
    mProvider = widget.provider;
    final s = mProvider.getUsers().doOnListen(() {
    }).doOnDone(() {
    }).listen((data) {
      //success
       setState(() {
         users.addAll((data as List).map((user) => User.fromJson(user)).toList());
       });
    }, onError: (e) {
      //error
      dispatchFailure(context, e);
    });
    mProvider.addSubscription(s);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("New"),
        backgroundColor: Colors.blue,
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

  @override
  void onClick(String action) {
    // TODO: implement onClick
  }
}