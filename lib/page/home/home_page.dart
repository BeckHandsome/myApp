import 'package:amap_location/amap_location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/tool/dio_util.dart';
import 'package:my_app/widgets/widget_marquee_control.dart';
import 'package:permission_handler/permission_handler.dart';

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
      'name': '图片',
      'path': '/picture',
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
        geoLanguage: GeoLanguage.ZH,
        needsAddress: true,
      ));
      AMapLocationClient.onLocationUpate.listen((AMapLocation loc) {
        if (!mounted) return;
        _getAddress(loc);
      });
      AMapLocationClient.startLocation();
      return;
    } else {
      final status = await permission.request();
      if (status == PermissionStatus.granted) {
        await AMapLocationClient.startup(new AMapLocationOption(
          locationMode: AMapLocationMode.Hight_Accuracy,
          gpsFirst: true,
          desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyBest,
          geoLanguage: GeoLanguage.ZH,
          needsAddress: true,
        ));
        AMapLocationClient.onLocationUpate.listen((AMapLocation loc) {
          if (!mounted) return;
          _getAddress(loc);
        });
        AMapLocationClient.startLocation();
      }
    }
  }

  Future<void> _getAddress(AMapLocation loc) async {
    Fluttertoast.showToast(
      msg:
          "定位成功：经度${loc.longitude}纬度${loc.latitude}city${loc.city}formattedAddress${loc.formattedAddress}",
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Color(int.parse('0x0cf000000')).withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 16.0,
    );
    setState(() {
      _city = loc.city;
      if (_city != null) {
        AMapLocationClient.stopLocation();
      }
    });
  }

  //获取轮播图信息
  Future _getSwiperList() async {
    return DioUtil().get(NWApi.news, pathParams: {"type": 0, "page": 10});
  }

  // 获取视频
  Future _getVideoList() async {
    return DioUtil().get(NWApi.videoList);
  }

  @override
  void dispose() {
    super.dispose();
    AMapLocationClient.shutdown();
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
        child: ListView(
          children: [
            //轮播图
            Padding(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  maxHeight: 200.0, //最小高度为50像素
                ),
                child: FutureBuilder(
                  future: _getSwiperList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // 请求已结束
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        // 请求失败，显示错误
                        return Text("Error: ${snapshot.error}");
                      } else {
                        // 请求成功，显示数据 Text("Contents: ${snapshot.data}")
                        return Swiper(
                          scrollDirection: Axis.horizontal,
                          autoplay: true,
                          pagination: SwiperPagination(),
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              '${snapshot.data['data'][index]['imgsrc']}',
                              fit: BoxFit.fill,
                            );
                          },
                          itemCount: snapshot.data['data'].length,
                          onTap: (int index) {
                            NavigatorUtil.navigateTo(
                              context,
                              '/newsDetail',
                              params: {
                                "title": snapshot.data['data'][index]['title'],
                                "url": snapshot.data['data'][index]["url"]
                              },
                            );
                          },
                        );
                      }
                    } else {
                      // 请求未结束，显示loading
                      return Center(
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
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
            // 获取定位位置
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Row(
                children: [
                  Text('获取定位位置：'),
                  Text('$_city'),
                ],
              ),
            ),
            // 实时信息滚动
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: double.infinity, //宽度尽可能大
                  maxHeight: 50.0, //最小高度为50像素
                ),
                child: FutureBuilder(
                  future: _getVideoList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    // 请求已结束
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        // 请求失败，显示错误
                        return Text("Error: ${snapshot.error}");
                      } else {
                        // 请求成功，显示数据 Text("Contents: ${snapshot.data}")
                        return MarqueeControlWidget(
                          stepOffset: 300,
                          children: Row(
                            children: List.generate(
                              snapshot.data['data']['videoList'].length,
                              (index) => Padding(
                                padding: EdgeInsets.only(right: 20),
                                child: Text(
                                  '${snapshot.data['data']['videoList'][index]['title']}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: index % 2 == 0
                                        ? Color(0xFFEE8E2B)
                                        : Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    } else {
                      // 请求未结束，显示loading
                      return Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
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
