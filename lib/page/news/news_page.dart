import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/tool/dio_util.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 新闻
class NewsPage extends StatefulWidget {
  final Map<String, dynamic> params;
  NewsPage({Key key, this.params}) : super(key: key);
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with TickerProviderStateMixin {
  Map _params = {};
  TabController _tabController;
  List _tabs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
    _tabs = [
      {"name": "头条", "id": 0},
      {"name": "军事", "id": 1},
      {"name": "娱乐", "id": 2},
      {"name": "体育", "id": 3},
      {"name": "科技", "id": 4},
      {"name": "艺术", "id": 5},
      {"name": "教育", "id": 6},
      {"name": "要闻", "id": 7},
    ];
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${_params['name']}'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Material(
              color: Colors.black,
              child: ConstrainedBox(
                constraints: BoxConstraints(minWidth: double.infinity),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey)),
                  ),
                  child: TabBar(
                      labelColor: Colors.white,
                      isScrollable: true,
                      controller: _tabController,
                      tabs: _tabs
                          .map(
                            (i) => Tab(
                              text: "${i['name']}",
                            ),
                          )
                          .toList()),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: List.generate(_tabs.length, (index) {
                  return NewList(
                    type: index,
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewList extends StatefulWidget {
  final int type;
  NewList({Key key, this.type}) : super(key: key);
  _NewListState createState() => _NewListState();
}

class _NewListState extends State<NewList> {
  List _dataList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._getNewsData();
  }

  Future _getNewsData() async {
    DioUtil()
        .get(NWApi.news, pathParams: {"type": widget.type, "page": 20}).then(
      (res) => {
        print(res),
        if (res["msg"] == "success" && res['data'] != null)
          {
            setState(() {
              _dataList.addAll(res["data"]);
            })
          }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: List.generate(
                _dataList.length,
                (index) => GestureDetector(
                  onTap: () {
                    NavigatorUtil.navigateTo(
                      context,
                      '/newsDetail',
                      params: {
                        "title": _dataList[index]['title'],
                        "url": _dataList[index]["url"]
                      },
                    );
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(width: 1.0, color: Color(0xFF999999)),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  right: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text("${_dataList[index]["title"]}"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "${_dataList[index]["source"]} ",
                                          style: TextStyle(
                                              color: Color(0xFF888888)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                height: 100,
                                child: Image.network(
                                  "${_dataList[index]["imgsrc"]}",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
