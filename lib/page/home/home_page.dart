import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/routes/application.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List headerList = [
    {
      'image': 'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
      'name': '新闻',
      'path': '/news',
    },
    {
      'image': 'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
      'name': '天气',
      'path': '/weather',
    },
    {
      'image': 'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
      'name': '视频',
      'path': '/video',
    },
    {
      'image': 'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
      'name': '段子',
      'path': '/joke',
    },
    {
      'image': 'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
      'name': '招聘信息',
      'path': '/job',
    },
    {
      'image': 'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
      'name': '前端日报',
      'path': '/webDaily',
    },
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Wrap(
                runSpacing: 10.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.start,
                children: List.generate(
                  headerList.length,
                  (index) => GestureDetector(
                      child: FractionallySizedBox(
                        alignment: Alignment.center,
                        widthFactor: 0.2,
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                '${headerList[index]["image"]}',
                                width: 40,
                              ),
                            ),
                            Text('${headerList[index]["name"]}'),
                          ],
                        ),
                      ),
                      onTap: () {
                        // Navigator.pushNamed(
                        //     context, '${headerList[index]["path"]}',
                        //     arguments: {
                        //       'name': headerList[index]['name'],
                        //       'path': headerList[index]["path"]
                        //     });
                        var json = Uri.encodeComponent('${headerList[index]}');
                        Application.router.navigateTo(
                          context,
                          '${headerList[index]["path"]}?id=$json',
                          transition: TransitionType.fadeIn,
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
