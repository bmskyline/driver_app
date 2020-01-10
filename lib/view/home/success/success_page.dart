import 'package:driver_app/base/base.dart';
import 'package:driver_app/data/model/user_model.dart';
import 'package:driver_app/utils/widget_utils.dart';
import 'package:driver_app/view/detail/detail_page.dart';
import 'package:driver_app/view/home/success/success_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuccessPage extends PageProvideNode<SuccessProvider> {
  final BuildContext homeContext;
  SuccessPage(this.homeContext);

  @override
  Widget buildContent(BuildContext context) {
    return _SuccessContentPage(homeContext, mProvider);
  }
}

class _SuccessContentPage extends StatefulWidget {
  final BuildContext homeContext;
  final SuccessProvider provider;

  _SuccessContentPage(this.homeContext, this.provider);

  @override
  State<StatefulWidget> createState() {
    return _SuccessContentState(homeContext);
  }
}

class _SuccessContentState extends State<_SuccessContentPage>
    with TickerProviderStateMixin<_SuccessContentPage> {
  final BuildContext homeContext;

  _SuccessContentState(this.homeContext);

  SuccessProvider mProvider;
  List<User> users = List();

  @override
  void initState() {
    super.initState();
    mProvider = widget.provider;
    _loadData();
  }

  void _loadData() {
    final s =
        mProvider.getUsers().doOnListen(() {}).doOnDone(() {}).listen((data) {
      //success
      setState(() {
        users
            .addAll((data as List).map((user) => User.fromJson(user)).toList());
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
        title: Text("Success"),
        backgroundColor: Colors.orange,
      ),
      backgroundColor: Colors.black12,
      body: SizedBox.expand(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!mProvider.loading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              _loadData();
            }
          },
          child:
              Stack(alignment: AlignmentDirectional.center, children: <Widget>[
            ListView.builder(
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  child: Card(
                    color: Colors.blue[50].withOpacity(0.25),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          homeContext,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(user: users[index]),
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
            buildProgress()
          ]),
        ),
      ),
    );
  }

  Consumer<SuccessProvider> buildProgress() {
    return Consumer<SuccessProvider>(builder: (context, value, child) {
      return Visibility(
        child: CircularProgressIndicator(),
        visible: value.loading,
      );
    });
  }
}
