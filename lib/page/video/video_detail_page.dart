import 'package:flutter/material.dart';
import 'package:my_app/tool/dio_util.dart';
import 'package:my_app/tool/fluro_convert_util.dart';
import 'package:my_app/widgets/widget_video.dart';

class VideoDetailPage extends StatefulWidget {
  final Map<String, dynamic> params;
  VideoDetailPage({Key key, this.params}) : super(key: key);
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  Map _params = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
  }

  Future _getDetail() async {
    return DioUtil().get(NWApi.videoDetail, pathParams: {"vid": _params['id']});
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${_params['title']}"),
      ),
      body: Container(
        child: FutureBuilder(
          future: _getDetail(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // 请求已结束
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                // 请求失败，显示错误
                return Text("Error: ${snapshot.error}");
              } else {
                // 请求成功，显示数据 Text("Contents: ${snapshot.data}")
                return Container(
                  child: Column(
                    children: [
                      WidgetVideo(url: '${snapshot.data['data']['mp4Hd_url']}'),
                      Row(
                        children: [
                          Text('更新时间：${snapshot.data['data']['ptime']}'),
                          Text('来源：${snapshot.data['data']['source']}')
                        ],
                      ),
                      Text('${snapshot.data['data']['title']}')
                    ],
                  ),
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
    );
  }
}
