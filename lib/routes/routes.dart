import 'package:flutter/cupertino.dart';
import 'package:my_app/page/404_page.dart';
import 'package:fluro/fluro.dart';
import 'package:my_app/routes/routes_all.dart';

class Routes {
  static void configureRoutes(Router router) {
    //notFoundHandler是匹配不到路由时执行出发的
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          NotRoutePage(),
    );
    PageRouter.handlerRouter.forEach((path, handler) {
      router.define(path,
          handler: handler, transitionType: TransitionType.inFromRight);
    });
  }
}
