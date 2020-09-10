import 'package:flutter/material.dart';

// 新闻
class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('新闻'),
      ),
      body: Container(
        child: Text('新闻'),
      ),
    );
  }
}
