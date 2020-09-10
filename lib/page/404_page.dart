import 'package:flutter/material.dart';

// 招聘信息
class NotRoutePage extends StatefulWidget {
  NotRoutePage({Key key}) : super(key: key);
  _NotRoutePageState createState() => _NotRoutePageState();
}

class _NotRoutePageState extends State<NotRoutePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('404暂无该页面'),
        ),
      ),
    );
  }
}
