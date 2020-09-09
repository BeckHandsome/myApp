import 'package:flutter/cupertino.dart';
import 'package:my_app/page/404_page.dart';
import 'package:my_app/page/home/home.dart';
import 'package:fluro/fluro.dart';
// import 'package:my_app/page/login.dart';
import 'package:my_app/routes/routes_all.dart';

class Routes {
  // static String root = '/';
  // static String login = '/login';
  // // 在这里我定义了一个map集合，key是页面的path,value是按照fluro的要求是一个Handler的实例
  // static final Map<String, Handler> pageRouter = {
  //   root: Handler(handlerFunc: (BuildContext context, params) {
  //     return Home();
  //   }),
  //   login: Handler(handlerFunc: (BuildContext context, params) {
  //     return Login();
  //   })
  // };
  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context, params) => NotRoutePage(),
    );

    PageRouter.handlerRouter.forEach((path, handler) {
      router.define(path,
          handler: handler, transitionType: TransitionType.inFromRight);
    });
    // router.define(
    //   root,
    //   handler: Handler(handlerFunc: (BuildContext context, params) => Home()),
    // );
    // router.define(
    //   login,
    //   handler: Handler(handlerFunc: (BuildContext context, params) => Login()),
    // );
  }
}
