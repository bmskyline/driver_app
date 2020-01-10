import 'package:driver_app/view/home/home_page.dart';
import 'package:driver_app/view/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Provider.debugCheckInvalidValueType = null;
  Widget _defaultHome = LoginPage("Login");
  if (spUtil.getString("TOKEN") != null && spUtil.getString("TOKEN") != "") {
    _defaultHome = HomePage();
  }
  runApp(MyApp(_defaultHome));
}

class MyApp extends StatelessWidget {
  Widget defaultHome;
  MyApp(this.defaultHome);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: defaultHome);
  }
}
