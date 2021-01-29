import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app/widgets/widget_switch.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:flutter/services.dart';

class PushMessagePage extends StatefulWidget {
  PushMessagePage({Key key}) : super(key: key);
  _PushMessagePageState createState() => _PushMessagePageState();
}

class _PushMessagePageState extends State<PushMessagePage> {
  bool _value = false;
  bool _isOpenNotification = false;
  String debugLable = 'Unknown';
  final JPush jpush = new JPush();
  final _permission = Permission.notification;
  @override
  void initState() {
    super.initState();
    initNotification();
    initPlatformState();
  }

  /// 判断是否打开了通知权限
  void initNotification() async {
    PermissionStatus status = await _permission.status;
    if (status == PermissionStatus.granted) {
      setState(() {
        _isOpenNotification = true;
        _value = true;
      });
    } else {
      _isOpenNotification = false;
      _value = false;
    }
  }
  // 编写initPlatformState方法

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      /*监听响应方法的编写*/
      jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
        print(">>>>>>>>>>>>>>>>>flutter 接收到推送: $message");
        setState(() {
          debugLable = "接收到推送: $message";
        });
      }, onOpenNotification: (Map<String, dynamic> message) async {
        print("flutter onOpenNotification: $message");
        setState(() {
          debugLable = "flutter onOpenNotification: $message";
        });
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print("flutter onReceiveMessage: $message");
        setState(() {
          debugLable = "flutter onReceiveMessage: $message";
        });
      }, onReceiveNotificationAuthorization:
              (Map<String, dynamic> message) async {
        print("flutter onReceiveNotificationAuthorization: $message");
        setState(() {
          debugLable = "flutter onReceiveNotificationAuthorization: $message";
        });
      });
    } on PlatformException {
      platformVersion = '平台版本获取失败，请检查！';
    }
    if (!mounted) {
      return;
    }
    setState(() {
      debugLable = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('消息推送设置'),
      ),
      body: Container(
        color: Color(0xFFF9FBFF),
        child: Column(
          children: [
            WidgetSwitch(
              title: Text('推送消息设置'),
              subtitle: Text(
                _value ? '有消息时通知' : '你可能错过重要信息通知，点击开启消息通知',
                style: TextStyle(
                    color: !_value ? Colors.red : Colors.blue, fontSize: 12.0),
              ),
              switchValue: _value,
              onChanged: (value) {
                initNotification();
                if (_isOpenNotification) {
                  setState(() {
                    _value = value;
                  });
                } else {
                  /// 打开通知设置
                  jpush.openSettingsForNotification();
                  // openAppSettings();
                }
              },
            ),
            Center(
              child: RaisedButton.icon(
                icon: Icon(Icons.send),
                label: Text("点我发送通知"),
                onPressed: () {
                  /*三秒后出发本地推送*/
                  var fireDate = DateTime.fromMillisecondsSinceEpoch(
                      DateTime.now().millisecondsSinceEpoch + 3000);
                  var localNotification = LocalNotification(
                    id: 234,
                    title: '我是推送测试标题',
                    buildId: 1,
                    content: '看到了说明已经成功了',
                    fireTime: fireDate,
                    badge: 1,
                    subtitle: '一个测试',
                  );
                  jpush.sendLocalNotification(localNotification).then((res) {
                    setState(() {
                      debugLable = res;
                    });
                  });
                },
              ),
            ),
            Text(debugLable ?? "Unknown"),
          ],
        ),
      ),
    );
  }
}
