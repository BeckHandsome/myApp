import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/page/boot_page.dart';
import 'package:my_app/routes/application.dart';
import 'package:my_app/routes/routes.dart';

void main() {
  //注入路由
  final router = Router();
  Routes.configureRoutes(router);
  Application.router = router;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue[800],
        primarySwatch: Colors.blue,
        accentColor: Colors.cyan[600],
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: Application.router.generator, //全局注入路由
      home: BootPage(),
    );
  }
}
