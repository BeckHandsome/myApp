import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/widgets/widget_marquee_control.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
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
  final _permission = Permission.location;
  String _city = '';
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _requestPermission(_permission);
  }

  // 判断获取位置权限
  Future<void> _requestPermission(Permission permission) async {
    // if ( await permission.status == PermissionStatus.undetermined) {
    //     Toast.toast(context, msg: "请手动打开定位功能");
    //     return;
    // }
    if (await permission.status == PermissionStatus.granted) {
      await AMapLocationClient.startup(new AMapLocationOption(
        locationMode: AMapLocationMode.Hight_Accuracy,
        gpsFirst: true,
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyBest,
      ));
      AMapLocation res = await AMapLocationClient.getLocation(true);
      Fluttertoast.showToast(
        msg: "定位成功：经度${res.longitude}纬度${res.latitude}",
        // gravity: ToastGravity.CENTER,
        // timeInSecForIosWeb: 1,
        // backgroundColor: Color(int.parse('0x0cf000000')).withOpacity(0.5),
        // textColor: Colors.white,
        // fontSize: 16.0,
      );
      setState(() {
        _city = res.citycode;
      });
      return;
    } else {
      final status = await permission.request();
      if (status == PermissionStatus.granted) {
        await AMapLocationClient.startup(new AMapLocationOption(
          locationMode: AMapLocationMode.Hight_Accuracy,
          gpsFirst: true,
          desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyBest,
        ));
        AMapLocation res = await AMapLocationClient.getLocation(true);
        Fluttertoast.showToast(
          msg: "定位成功：经度${res.longitude}纬度${res.latitude}",
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Color(int.parse('0x0cf000000')).withOpacity(0.5),
          textColor: Colors.white,
          fontSize: 16.0,
        );
        setState(() {
          _city = res.citycode;
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    AMapLocationClient.shutdown();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          children: [
            //轮播图
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  maxHeight: 50.0, //最小高度为50像素
                ),
                child: Swiper(
                  scrollDirection: Axis.horizontal,
                  autoplay: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Text('${headerList[index]['name']}');
                  },
                  itemCount: headerList.length,
                  // control: SwiperControl(),
                ),
              ),
            ),
            // 上部列表的展示
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
                        NavigatorUtil.navigateTo(
                          context,
                          '${headerList[index]["path"]}',
                          params: headerList[index],
                        );
                      }),
                ),
              ),
            ),
            // 实时信息滚动
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Text('获取定位位置：'),
                  Text('$_city'),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  maxHeight: 50.0, //最小高度为50像素
                ),
                child: MarqueeControlWidget(
                  stepOffset: 300,
                  children: Row(
                    children: List.generate(
                      4,
                      (index) => Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          '手机用户155****052$index借款成功',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFEE8E2B),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(0),
              child: Material(
                color: Colors.transparent,
                child: TabBar(
                  controller: _tabController,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(),
                  tabs: [
                    Tab(
                      text: '全部',
                      icon: Icon(Icons.person),
                      iconMargin: EdgeInsets.only(bottom: 0),
                    ),
                    Tab(
                      text: '最新',
                      icon: Icon(Icons.person),
                      iconMargin: EdgeInsets.only(bottom: 0),
                    ),
                    Tab(
                      text: '最多',
                      icon: Icon(Icons.person),
                      iconMargin: EdgeInsets.only(bottom: 0),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Text('11111'),
                  Text('11111'),
                  Text('11111'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
