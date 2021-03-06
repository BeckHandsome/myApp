import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:my_app/page/home/home.dart';
import 'package:my_app/page/job/job_page.dart';
import 'package:my_app/page/login.dart';
import 'package:my_app/page/my_page/device_page.dart';
import 'package:my_app/page/my_page/push_message_page.dart';
import 'package:my_app/page/my_page/set_page.dart';
import 'package:my_app/page/my_page/user_info_page.dart';
import 'package:my_app/page/news/news_detail_page.dart';
import 'package:my_app/page/news/news_page.dart';
import 'package:my_app/page/picture/picture_page.dart';
import 'package:my_app/page/video/video_detail_page.dart';
import 'package:my_app/page/video/video_page.dart';
import 'package:my_app/page/weather/weather_page.dart';
import 'package:my_app/page/webDaily/web_daily_page.dart';

class PageRouter {
  // 使用命名路由
  static String root = '/';
  static String login = '/login';
  static String news = '/news';
  static String newsDetail = '/newsDetail';
  static String weather = '/weather';
  static String video = '/video';
  static String videoDetail = '/videoDetail';
  static String picture = '/picture';
  static String job = '/job';
  static String webDaily = '/webDaily';
  static String userInfo = '/userInfo';
  static String mySet = '/set';
  static String devicePage = '/devicePage';
  static String pushMessagePage = '/pushMessagePage';

  // 在这里我定义了一个map集合，key是页面的path,value是按照fluro的要求是一个Handler的实例
  static final Map<String, Handler> handlerRouter = {
    root: Handler(handlerFunc: (BuildContext context, parameters) {
      return Home();
    }),
    login: Handler(handlerFunc: (BuildContext context, parameters) {
      return Login();
    }),
    // 新闻
    news: Handler(handlerFunc: (BuildContext context, parameters) {
      return NewsPage();
    }),
    // 新闻详情
    newsDetail: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return NewsDetailPage(params: parameters);
    }),
    // 天气
    weather: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return WeatherPage(params: parameters);
    }),
    // 视频
    video: Handler(handlerFunc: (BuildContext context, parameters) {
      return VideoPage();
    }),
    // 视频详情
    videoDetail: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return VideoDetailPage(params: parameters);
    }),
    // 图片
    picture: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return PicturePage(params: parameters);
    }),
    // 招聘信息
    job: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return JobPage(params: parameters);
    }),
    // 前端日报
    webDaily: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return WebDailyPage(params: parameters);
    }),
    // 个人信息
    userInfo: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return UserInfoPage();
    }),
    // 设置
    mySet: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return SetPage();
    }),
    // 登录设备
    devicePage: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return DevicePage();
    }),
    // 消息推送
    pushMessagePage: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> parameters) {
      return PushMessagePage();
    }),
  };
}
