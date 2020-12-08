import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/widget_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MessagePage extends StatefulWidget {
  MessagePage({Key key}) : super(key: key);
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with AutomaticKeepAliveClientMixin {
  List<String> items = ["1", "2", "3", "4", "5", "6"];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
    super.build(context);
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
            itemBuilder: (c, i) => CardList(
              text: items[i],
            ),
            itemExtent: 100.0,
            itemCount: items.length,
          ),
        ),
      ),
    );
  }
}

class CardList extends StatefulWidget {
  final String text;
  CardList({Key key, this.text}) : super(key: key);
  _CardListState createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  String _text;
  String _operation = "No Gesture detected!"; //保存事件名
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _text = widget.text;
  }

  void updateText(String text) {
    //更新显示的事件名
    setState(() {
      _operation = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      color: Colors.red,
      child: Slidable(
        actionPane: SlidableScrollActionPane(), //滑出选项的面板 动画
        // actionExtentRatio: 0.25,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => updateText("Tap"), //点击
            onDoubleTap: () => updateText("DoubleTap"), //双击
            onLongPress: () => updateText("LongPress"), //长按
            child: Column(
              children: [
                Text('$_text$_operation'),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          //左侧按钮列表
          IconSlideAction(
            caption: 'Archive',
            color: Colors.blue,
            icon: Icons.archive,
            onTap: () {},
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () {},
          ),
        ],
        secondaryActions: <Widget>[
          //右侧按钮列表
          IconSlideAction(
            caption: 'More',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () {},
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            closeOnTap: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
