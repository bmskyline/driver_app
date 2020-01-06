import 'package:driver_app/base/base.dart';
import 'package:driver_app/utils/toast_utils.dart';
import 'package:driver_app/utils/widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_provider.dart';

class HomePage extends PageProvideNode<HomeProvider> {

  HomePage(String title) : super(params: [title]);

  @override
  Widget buildContent(BuildContext context) {
    return _HomeContentPage(mProvider);
  }
}

class _HomeContentPage extends StatefulWidget {
  final HomeProvider provider;

  _HomeContentPage(this.provider);

  @override
  State<StatefulWidget> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<_HomeContentPage>
    with TickerProviderStateMixin<_HomeContentPage>
    implements Presenter {

  HomeProvider mProvider;

  AnimationController _controller;
  Animation<double> _animation;

  static const ACTION_LOGIN = "login";

  @override
  void initState() {
    super.initState();
    mProvider = widget.provider;
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween(begin: 295.0, end: 48.0).animate(_controller)
      ..addListener(() {
        mProvider.btnWidth = _animation.value;
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void onClick(String action) {
    if (ACTION_LOGIN == action) {
      login();
    }
  }

  void login() {
    final s = mProvider.login().doOnListen(() {
      _controller.forward();
    }).doOnDone(() {
      _controller.reverse();
    }).listen((_) {
      //success
      Toast.show("login success");
    }, onError: (e) {
      //error
      dispatchFailure(context, e);
    });
    mProvider.addSubscription(s);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: Text(mProvider.title),
        ),
        body: DefaultTextStyle(
          style: TextStyle(color: Colors.black),
          child: Column(
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.person),
                  labelText: 'Account',
                ),
                autofocus: false,
                onChanged: (str) => mProvider.userName = str,
              ),
              TextField(
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  icon: Icon(Icons.lock),
                  labelText: 'Password',
                ),
                autofocus: false,
                onChanged: (str) => mProvider.password = str,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30.0),
              ),
              buildLoginBtnProvide(),
              const Text(
                "Response:",
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.start,
              ),
              Expanded(
                child: Container(
                  constraints: BoxConstraints(minWidth: double.infinity),
                  margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
                  padding: EdgeInsets.all(5.0),
                  decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
                  child: Selector<HomeProvider, String>(
                    selector: (_, data) => data.response,
                    builder: (context, value, child) {
                      return Text(value);
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  Consumer<HomeProvider> buildLoginBtnProvide() {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return CupertinoButton(
          onPressed: value.loading ? null : () => onClick(ACTION_LOGIN),
          pressedOpacity: 0.8,
          child: Container(
            alignment: Alignment.center,
            width: value.btnWidth,
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                gradient: LinearGradient(colors: [
                  Color(0xFF686CF2),
                  Color(0xFF0E5CFF),
                ]),
                boxShadow: [BoxShadow(color: Color(0x4D5E56FF), offset: Offset(0.0, 4.0), blurRadius: 13.0)]),
            child: buildLoginChild(value),
          ),
        );
      },
    );
  }


  Widget buildLoginChild(HomeProvider value) {
    if (value.loading) {
      return const CircularProgressIndicator();
    } else {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'Login With Github Account',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
        ),
      );
    }
  }
}