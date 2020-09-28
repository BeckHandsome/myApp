import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Center(
          child: ClipOval(
            child: Image.asset(
              'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
              // fit: BoxFit.fitWidth,
              width: 40,
            ),
          ),
        ),
        title: Text("myapp"),
      ),
      body: Container(
        child: Text('消息页面'),
      ),
    );
  }
}
