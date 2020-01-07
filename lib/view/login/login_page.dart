import 'package:driver_app/base/base.dart';
import 'package:driver_app/utils/toast_utils.dart';
import 'package:driver_app/utils/widget_utils.dart';
import 'package:driver_app/view/home/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_provider.dart';

class LoginPage extends PageProvideNode<LoginProvider> {

  LoginPage(String title) : super(params: [title]);

  @override
  Widget buildContent(BuildContext context) {
    return _LoginContentPage(mProvider);
  }
}

class _LoginContentPage extends StatefulWidget {
  final LoginProvider provider;

  _LoginContentPage(this.provider);

  @override
  State<StatefulWidget> createState() {
    return _LoginContentState();
  }
}

class _LoginContentState extends State<_LoginContentPage>
    with TickerProviderStateMixin<_LoginContentPage>
    implements Presenter {

  LoginProvider mProvider;

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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
    final s = mProvider.login().doOnListen(() {
      _controller.forward();
    }).doOnDone(() {
      _controller.reverse();
    }).listen((_) {
      //success

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
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Padding(padding: EdgeInsets.only(top: 64.0)),
                Image(image: AssetImage('assets/logo.png'),
                  width: 120,
                  height: 120,),
                const Padding(padding: EdgeInsets.only(top: 32.0)),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      icon: Icon(Icons.person),
                      labelText: 'Account',
                    ),
                    autofocus: false,
                    onChanged: (str) => mProvider.userName = str,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: TextField(
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
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 30.0),
                ),
                buildLoginBtnProvide()
              ],
            ),
          ),
        ),
      ),
    );
  }


  Consumer<LoginProvider> buildLoginBtnProvide() {
    return Consumer<LoginProvider>(
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


  Widget buildLoginChild(LoginProvider value) {
    if (value.loading) {
      return const CircularProgressIndicator();
    } else {
      return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'Login',
          maxLines: 1,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.white),
        ),
      );
    }
  }
}