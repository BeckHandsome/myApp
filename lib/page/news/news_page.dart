import 'package:flutter/material.dart';

// 新闻
class NewsPage extends StatefulWidget {
  final Map<String, dynamic> params;
  NewsPage({Key key, this.params}) : super(key: key);
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.params['name']}'),
      ),
      body: Container(
        child: Text('${widget.params}'),
      ),
    );
  }
}
