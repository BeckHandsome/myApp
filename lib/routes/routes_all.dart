import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/page/home/home.dart';
import 'package:my_app/page/job/job_page.dart';
import 'package:my_app/page/joke/joke_page.dart';
import 'package:my_app/page/login.dart';
import 'package:my_app/page/news/news_page.dart';
import 'package:my_app/page/weather/weather_page.dart';
import 'package:my_app/page/webDaily/web_daily_page.dart';

class PageRouter {
  static String root = '/';
  static String login = '/login';
  static String news = '/news';
  static String weather = '/weather';
  // static String video = '/video';
  static String joke = '/joke';
  static String job = '/job';
  static String webDaily = '/webDaily';

  // 在这里我定义了一个map集合，key是页面的path,value是按照fluro的要求是一个Handler的实例
  static final Map<String, Handler> handlerRouter = {
    root: Handler(handlerFunc: (BuildContext context, params) {
      return Home();
    }),
    login: Handler(handlerFunc: (BuildContext context, params) {
      return Login();
    }),
    // 新闻
    news: Handler(handlerFunc: (BuildContext context, params) {
      return NewsPage();
    }),
    // 天气
    weather: Handler(handlerFunc: (BuildContext context, params) {
      return WeatherPage();
    }),
    // 视频
    // video: Handler(handlerFunc: (BuildContext context, params) {
    //   return Login();
    // }),
    // 段子
    joke: Handler(handlerFunc: (BuildContext context, params) {
      return JokePage();
    }),
    // 招聘信息
    job: Handler(handlerFunc: (BuildContext context, params) {
      return JobPage();
    }),
    // 前端日报
    webDaily: Handler(handlerFunc: (BuildContext context, params) {
      return WebDailyPage();
    }),
  };
}
