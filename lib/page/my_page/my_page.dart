import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    'images/u=2070453827,1163403148&fm=26&gp=0.jpg',
                    // fit: BoxFit.fitWidth,
                    width: 40,
                  ),
                ),
                Text('用户名')
              ],
            ),
            pinned: true,
            expandedHeight: 150.0,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                "images/timg.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  //创建列表项
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xffEDEDED),
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.verified_user),
                          title: Text('个人资料'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xffEDEDED),
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('设置'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xffEDEDED),
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.system_update),
                          title: Text('检测更新'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xffEDEDED),
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.cached),
                          title: Text('清除缓存'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xffEDEDED),
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.room_service),
                          title: Text('客服'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              width: 1,
                              color: Color(0xffEDEDED),
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.home),
                          title: Text('关于'),
                          trailing: Icon(Icons.keyboard_arrow_right),
                        ),
                      ),
                    ],
                  );
                },
                childCount: 1, //50个列表项
              ),
            ),
          ),
        ],
      ),
    );
  }
}
