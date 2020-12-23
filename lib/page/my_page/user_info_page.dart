import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/tool/util.dart';
import 'package:my_app/widgets/widget_border_bottom_list_tile.dart';
import 'package:my_app/widgets/widget_select.dart';

class UserInfoPage extends StatefulWidget {
  UserInfoPage({Key key}) : super(key: key);
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('个人信息'),
      ),
      body: Container(
        child: Column(
          children: [
            BorderBottomListTileWidget(
              title: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('头像'),
                  ClipOval(
                    child: Image.asset(
                      'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
                      width: 40,
                    ),
                  ),
                ],
              ),
            ),
            BorderBottomListTileWidget(
              title: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('昵称'),
                  Text('用户名'),
                ],
              ),
            ),
            BorderBottomListTileWidget(
              title: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('性别'),
                  Text('女'),
                ],
              ),
              onTap: () {
                SelectWidget.showSelect(
                  context,
                  title: '性别',
                  data: [
                    {"name": '男', 'id': '1'},
                    {"name": "女", "id": '2'}
                  ],
                  initialId: "2",
                  onSuccess: (context, _changeData) {
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
