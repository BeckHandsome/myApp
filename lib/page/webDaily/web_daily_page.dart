import 'package:flutter/material.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 前端日报
class WebDailyPage extends StatefulWidget {
  final Map<String, dynamic> params;
  WebDailyPage({Key key, this.params}) : super(key: key);
  _WebDailyPageState createState() => _WebDailyPageState();
}

class _WebDailyPageState extends State<WebDailyPage> {
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
        child: Text('前端日报'),
      ),
    );
  }
}
