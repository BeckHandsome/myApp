import 'package:flutter/material.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 段子
class JokePage extends StatefulWidget {
  final Map<String, dynamic> params;
  JokePage({Key key, this.params}) : super(key: key);
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
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
        child: Text('段子'),
      ),
    );
  }
}
