import 'package:shared_preferences/shared_preferences.dart';

// 本地存储数据 添加或者更新
sharedAddAndUpdate(String key, Object dataType, Object data) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (dataType) {
    case bool:
      await prefs.setBool(key, data);
      break;
    case String:
      await prefs.setString(key, data);
      break;
    case double:
      await prefs.setDouble(key, data);
      break;
    case int:
      await prefs.setInt(key, data);
      break;
    case List:
      await prefs.setStringList(key, data);
      break;
    default:
      await prefs.setString(key, data.toString());
  }
}

// 获取本地存储的数据
sharedGetData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return await prefs.get(key);
}

// 移除本地存储的数据
sharedDeleteData(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}
