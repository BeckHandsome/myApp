import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_app/tool/dio_util.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 段子
class PicturePage extends StatefulWidget {
  final Map<String, dynamic> params;
  PicturePage({Key key, this.params}) : super(key: key);
  _PicturePageState createState() => _PicturePageState();
}

class _PicturePageState extends State<PicturePage> {
  Map _params = {};
  List _dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
    _getPicture();
  }

  Future _getPicture() async {
    DioUtil().get(NWApi.picture, pathParams: {"page": 10}).then((res) => {
          print(res),
          if (res["msg"] == "success" && res['data'] != null)
            {
              setState(() {
                _dataList.addAll(res["data"]);
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${_params['name']}'),
      ),
      body: Container(
        color: Color(0xFFEDEFF3),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(0),
              child: Wrap(
                runSpacing: 10.0, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.start,
                children: List.generate(
                  _dataList.length,
                  (index) => GestureDetector(
                    child: FractionallySizedBox(
                        alignment: Alignment.center,
                        widthFactor: 0.5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          child: Container(
                            margin: EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: CachedNetworkImage(
                                    imageUrl: "${_dataList[index]['scover']}",
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    placeholder: (context, url) => Center(
                                      child: SizedBox(
                                        width: 30,
                                        height: 30,
                                        child: CircularProgressIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  width: double.infinity,
                                  height: 200.0,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    left: 5.0,
                                    right: 5.0,
                                    bottom: 5.0,
                                  ),
                                  child: Text('${_dataList[index]["setname"]}'),
                                ),
                              ],
                            ),
                          ),
                        )),
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
