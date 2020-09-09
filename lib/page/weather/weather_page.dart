import 'package:flutter/material.dart';

// 天气
class WeatherPage extends StatefulWidget {
  WeatherPage({Key key}) : super(key: key);
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('天气'),
      ),
      body: Container(
        child: Text('天气'),
      ),
    );
  }
}
