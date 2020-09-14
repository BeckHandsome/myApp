import 'package:flutter/material.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 天气
class WeatherPage extends StatefulWidget {
  final Map<String, dynamic> params;
  WeatherPage({Key key, this.params}) : super(key: key);
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
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
        child: Text('天气'),
      ),
    );
  }
}
