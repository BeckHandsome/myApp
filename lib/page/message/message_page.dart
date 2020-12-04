import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/widget_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List<String> items = ["1", "2", "3", "4", "5", "6"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 3000), () {
      setState(() {
        items = ["1", "2", "3", "4", "5", "6"];
      });
    });
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length + 1).toString());
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        child: WidgetRefresh(
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            itemBuilder: (c, i) => Card(child: Center(child: Text(items[i]))),
            itemExtent: 100.0,
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}
