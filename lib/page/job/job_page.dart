import 'package:flutter/material.dart';

// 招聘信息
class JobPage extends StatefulWidget {
  final Map<String, dynamic> parameters = {};
  JobPage(Map<String, dynamic> parameters, {Key key}) : super(key: key);
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('招聘信息'),
      ),
      body: Container(
        child: Text('招聘信息'),
      ),
    );
  }
}
