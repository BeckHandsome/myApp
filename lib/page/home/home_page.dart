import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/widgets/widget_marquee_control.dart';

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
          ],
        ),
      ),
    );
  }
}
