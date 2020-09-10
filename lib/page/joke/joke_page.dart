import 'package:flutter/material.dart';

// 段子
class JokePage extends StatefulWidget {
  JokePage({Key key}) : super(key: key);
  _JokePageState createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('段子'),
      ),
      body: Container(
        child: Text('段子'),
      ),
    );
  }
}
