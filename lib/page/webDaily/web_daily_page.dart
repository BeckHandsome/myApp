import 'package:flutter/material.dart';

// 前端日报
class WebDailyPage extends StatefulWidget {
  WebDailyPage({Key key}) : super(key: key);
  _WebDailyPageState createState() => _WebDailyPageState();
}

class _WebDailyPageState extends State<WebDailyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('前端日报'),
      ),
      body: Container(
        child: Text('前端日报'),
      ),
    );
  }
}
