import 'package:flutter/material.dart';
import 'package:my_app/routes/navigator_util.dart';
import 'package:my_app/tool/util.dart';
import 'package:my_app/widgets/widget_drow_progress.dart';

class BootPage extends StatefulWidget {
  @override
  _BootPageState createState() => _BootPageState();
}

class _BootPageState extends State<BootPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _delayedGoHomePage();
  }

  _delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 2), () {
      _get();
    });
  }

  _clickJeep() {
    _get();
  }

  // 模拟是否需要在次登录
  _get() async {
    print(await sharedGetData('password'));
    if (await sharedGetData('password') != null &&
        await sharedGetData('password') == '123456') {
      Navigator.pop(context);
      NavigatorUtil.navigateTo(context, '/', replace: true, clearStack: true);
    } else {
      Navigator.pop(context);
      NavigatorUtil.navigateTo(context, '/login',
          replace: true, clearStack: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: new Image.asset(
              "images/79a00895ly1gfsxmumpncg205k09t7wh.gif",
              fit: BoxFit.cover,
            ),
            constraints: new BoxConstraints.expand(),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(30),
              child: SkipDownTimeProgress(
                Colors.red,
                22.0,
                new Duration(seconds: 2),
                new Size(25.0, 25.0),
                skipText: "跳过",
                clickListener: _clickJeep,
              ),
            ),
          ),
        ],
      ), // 构建主页面
    );
  }
}
