import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
            Text('测试listView'),
          ],
        ),
      ),
    );
  }
}
