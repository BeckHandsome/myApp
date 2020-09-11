import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/routes/application.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 分装fluro 路由跳转
class NavigatorUtil {
  static navigateTo(
    BuildContext context,
    String path, {
    Map<String, dynamic> params, //params为了解决自己页面在path上拼接更多的参数
    bool replace = false,
    bool clearStack = false,
    TransitionType transition = TransitionType.fadeIn,
  }) {
    if (params != null) {
      String query = '';
      int index = 0;
      for (var key in params.keys) {
        String value = FluroConvertUtils.fluroCnParamsEncode(
            params[key]); // 对参数进行encode，解决参数中有特殊字符，影响fluro路由匹配
        if (index == 0) {
          query = '?';
        } else {
          query = query + '\&';
        }
        query += '$key=$value';
        index++;
      }
      path = path + query;
    }
    Application.router.navigateTo(
      context,
      path,
      transition: transition,
    );
  }
  // 路由的返回直接用router提供的就行 Navigator.pop(context);
}
