import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String _cacheSizeStr = '';
  @override
  void initState() {
    super.initState();
    loadCache();
  }

  ///获取缓存（加载缓存）
  Future<Null> loadCache() async {
    Directory tempDir = await getTemporaryDirectory();
    double value = await _getTotalSizeOfFilesInDir(tempDir);
    tempDir.list(followLinks: false, recursive: true).listen((file) {
      //打印每个缓存文件的路径
      print(file.path);
    });
    print('临时目录大小: ' + value.toString());
    setState(() {
      _cacheSizeStr = _renderSize(value); // _cacheSizeStr用来存储大小的值
    });
  }

  ///循环计算文件的大小（递归）
  Future<double> _getTotalSizeOfFilesInDir(final FileSystemEntity file) async {
    if (file is File) {
      int length = await file.length();
      return double.parse(length.toString());
    }
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      double total = 0;
      if (children != null)
        for (final FileSystemEntity child in children)
          total += await _getTotalSizeOfFilesInDir(child);
      return total;
    }
    return 0;
  }

  /// 格式化缓存文件大小
  _renderSize(double value) {
    if (null == value) {
      return 0;
    }
    List<String> unitArr = List()..add('B')..add('K')..add('M')..add('G');
    int index = 0;
    while (value > 1024) {
      index++;
      value = value / 1024;
    }
    String size = value.toStringAsFixed(2);
    return size + unitArr[index];
  }

  /// 通过 path_provider 得到缓存目录，然后通过递归的方式，删除里面所有的文件。
  void _clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    //删除缓存目录
    await delDir(tempDir);
    await loadCache();
    Fluttertoast.showToast(msg: '清除缓存成功');
    Navigator.pop(context);
  }

  ///递归方式删除目录
  Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }

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
                          title: Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('清除缓存'),
                              Text('$_cacheSizeStr'),
                            ],
                          ),
                          trailing: Icon(Icons.keyboard_arrow_right),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                content: Text("是否清除缓存"),
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
                                      _clearCache();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
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
