import 'package:driver_app/view/hone/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'di/app_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage('Flutter Demo Home Page'),
    );
  }
}
