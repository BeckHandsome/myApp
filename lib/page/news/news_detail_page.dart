import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/tool/fluro_convert_util.dart';
import 'package:webview_flutter/webview_flutter.dart';

//新闻详情
class NewsDetailPage extends StatefulWidget {
  final Map<String, dynamic> params;
  NewsDetailPage({Key key, this.params}) : super(key: key);
  _NewsDetailPageState createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  Map _params = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_params['title']}"),
      ),
      body: Container(
        child: WebView(
          initialUrl: "${_params['url']}",
          //JS执行模式 是否允许JS执行
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
