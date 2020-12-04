import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/tool/dio_util.dart';
import 'package:my_app/tool/fluro_convert_util.dart';
import 'package:my_app/widgets/widget_back_top.dart';
import 'package:my_app/widgets/widget_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 视频
class VideoPage extends StatefulWidget {
  final Map<String, dynamic> params;
  VideoPage({Key key, this.params}) : super(key: key);
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with TickerProviderStateMixin {
  Map _params = {};
  TabController _tabController;
  List _tabs = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
    _tabs = [
      {"name": "精品视频", "id": 0},
      {"name": "搞笑视频", "id": 1},
      {"name": "美女视频", "id": 2},
      {"name": "体育视频", "id": 3},
      {"name": "新闻现场", "id": 4},
    ];
    _tabController =
        TabController(initialIndex: 0, length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('视频'),
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
                        .toList(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _tabs.map((index) {
                  return NewList(
                    type: index['id'],
                  );
                }).toList(),
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

/*
 * AutomaticKeepAliveClientMixin缓存页面
 *  @override
 * bool get wantKeepAlive => true;
 */
class _NewListState extends State<NewList> with AutomaticKeepAliveClientMixin {
  List _dataList = [];
  int _pageNumber = 10;
  String _loadingText = '';
  ScrollController _controller = ScrollController();
  @override
  bool get wantKeepAlive => true;

  ///see AutomaticKeepAliveClientMixin
  void initState() {
    // TODO: implement initState
    super.initState();
    _onRefresh();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _pageNumber = 10;
    _loadingText = '我在加载中...请等等我!!!!';
    // monitor network fetch
    await DioUtil().get(NWApi.videoList,
        pathParams: {"type": widget.type, "page": _pageNumber}).then(
      (res) => {
        print(res),
        if (res["msg"] == "success" && res['data'] != null)
          {
            setState(() {
              _dataList = res["data"];
            })
          }
        else
          {
            setState(() {
              _loadingText = '哈哈哈！！加载失败喽...';
            })
          }
      },
    );
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await DioUtil().get(NWApi.news,
        pathParams: {"type": widget.type, "page": _pageNumber += 10}).then(
      (res) => {
        if (res["msg"] == "success" && res['data'] != null)
          {
            setState(() {
              _dataList.addAll(res["data"]['videoList']);
            })
          }
      },
    );
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    /// see AutomaticKeepAliveClientMixin
    return _dataList.length > 0
        ? BackTop(
            controller: _controller,
            child: WidgetRefresh(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView(
                controller: _controller,
                children: List.generate(
                  _dataList.length,
                  (int i) => GestureDetector(
                    onTap: () {
                      NavigatorUtil.navigateTo(
                        context,
                        '/videoDetail',
                        params: {
                          "title": _dataList[i]['title'],
                          "id": _dataList[i]["vid"],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("${_dataList[i]["title"]}"),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${_dataList[i]["videosource"]} ",
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
                                    "${_dataList[i]["cover"]}",
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
          )
        : Center(
            child: Text('$_loadingText'),
          );
  }
}
