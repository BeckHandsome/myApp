import 'package:flutter/material.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/tool/util.dart';
import 'package:my_app/widgets/widget_border_bottom_list_tile.dart';

class SetPage extends StatefulWidget {
  SetPage({Key key}) : super(key: key);
  _SetPageState createState() => _SetPageState();
}

class _SetPageState extends State<SetPage> {
  @override
  void initState() {
    super.initState();
  }

  void _outLogin() {
    sharedDeleteData('userName');
    sharedDeleteData('password');
    NavigatorUtil.navigateTo(context, '/login',
        replace: true, clearStack: true);
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                BorderBottomListTileWidget(
                  title: Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('手机号'),
                      Text('138****0523'),
                    ],
                  ),
                ),
                BorderBottomListTileWidget(
                  title: Text('修改登录密码'),
                ),
                BorderBottomListTileWidget(
                  title: Text('登录设备'),
                ),
                BorderBottomListTileWidget(
                  title: Text('永久注销账号'),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: MaterialButton(
                  color: Colors.blue,
                  minWidth: double.infinity,
                  height: 50,
                  highlightColor: Colors.blue[700],
                  colorBrightness: Brightness.dark,
                  splashColor: Colors.grey,
                  child: Text("退出登录"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Text("是否退出登录"),
                        actions: [
                          FlatButton(
                            child: Text("取消"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          FlatButton(
                            child: Text("确定"),
                            onPressed: () {
                              _outLogin();
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
