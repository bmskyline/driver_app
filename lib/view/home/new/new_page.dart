import 'package:driver_app/base/base.dart';
import 'package:driver_app/utils/toast_utils.dart';
import 'package:driver_app/utils/widget_utils.dart';
import 'package:driver_app/view/detail/detail_page.dart';
import 'package:driver_app/view/home/new/new_provider.dart';
import 'package:flutter/material.dart';
import '../order_model.dart';

class NewPage extends PageProvideNode<NewProvider> {

  @override
  Widget buildContent(BuildContext context) {
    return _NewContentPage(mProvider);
  }
}

class _NewContentPage extends StatefulWidget {
  final NewProvider provider;

  _NewContentPage(this.provider);

  @override
  State<StatefulWidget> createState() {
    return _NewContentState();
  }
}

class _NewContentState extends State<_NewContentPage>
      with TickerProviderStateMixin<_NewContentPage>
      implements Presenter{

  NewProvider mProvider;

  @override
  void initState() {
    super.initState();
    mProvider = widget.provider;
    final s = mProvider.getUsers().doOnListen(() {
    }).doOnDone(() {
    }).listen((data) {
      //success
      print("cai lgi "+ data.list.length.toString());
    }, onError: (e) {
      //error
      dispatchFailure(context, e);
    });
    mProvider.addSubscription(s);
  }

  @override
  Widget build(BuildContext context) {
    List<Order> order = new List();
    order.add(Order("1", "196, New, NDC", "Clother", "0999999999","14:00"));
    order.add(Order("2", "196, New, NDC", "Computer", "0999799989","17:28"));
    order.add(Order("3", "196, New, NDC", "Glass", "0999999999","07:26"));
    order.add(Order("4", "196, New, NDC", "Phone", "0993929992","14:26"));
    order.add(Order("5", "196, New, NDC", "Shoes", "0999999999","19:33"));
    order.add(Order("6", "196, New, NDC", "Domain", "0999956999","14:26"));
    order.add(Order("7", "196, New, NDC", "Building materials", "0999999999","14:51"));
    order.add(Order("8", "196, New, NDC", "Helmet", "0993299659","14:50"));
    order.add(Order("9", "196, New, NDC", "Flower", "0999922999","14:00"));

    return Scaffold(
      appBar: AppBar(
        title: Text("New"),
        backgroundColor: Colors.blue,
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

  @override
  void onClick(String action) {
    // TODO: implement onClick
  }
}