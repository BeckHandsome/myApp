import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 新闻
class NewsPage extends StatefulWidget {
  final Map<String, dynamic> params;
  NewsPage({Key key, this.params}) : super(key: key);
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  Map _params = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${_params['name']}'),
      ),
      body: Container(
        child: Text('${_params['name']}'),
      ),
    );
  }
}
