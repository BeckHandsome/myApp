import 'package:flutter/material.dart';
import 'package:my_app/page/message/message_page.dart';
import 'package:my_app/page/my_page/my_page.dart';

import 'home_page.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> barPage = [HomePage(), MessagePage(), MyPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: barPage[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            //改变状态
            _currentIndex = index;
          });
        },
        iconSize: 16.0, //icon的大小
        fixedColor: Colors.red, //选中的颜色
        type: BottomNavigationBarType.fixed, //配置底部tabs可以有多个按钮
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("首页"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("消息"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text("我的"),
          ),
        ],
      ),
    );
  }
}
