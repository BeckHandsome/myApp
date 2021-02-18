import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/tool/fluro_convert_util.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqFlitePage extends StatefulWidget {
  final Map<String, dynamic> params;
  SqFlitePage({
    Key key,
    this.params,
  }) : super(key: key);
  @override
  _SqFlitePageState createState() => _SqFlitePageState();
}

@override
class _SqFlitePageState extends State<SqFlitePage> {
  Map _params = {};
  File _image;
  List<File> files;
  ImagePicker picker = ImagePicker();
  @override
  void initState() {
    super.initState();
    createNewDb('demo.db', _createTableSQL);
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
  }

  // 先创建db初始化
  Database db;
  String _createTableSQL =
      'CREATE TABLE student_table (id INTEGER PRIMARY KEY, name TEXT,age INTEGER)'; //创建学生表;
  Future createNewDb(String dbName, _createTableSQL) async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, dbName);
    print('数据库存储路径path' + path);
    //根据数据库文件路径和数据库版本号创建数据库表
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      //创建表，只回调一次
      await db.execute(_createTableSQL);
      await db.close();
    });
  }

/*拍照*/
  Future _takePhoto() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

/*相册*/
  Future _openGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  /*选取视频*/
  Future _getVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

/*拍摄视频*/
  Future _takeVideo() async {
    final pickedFile = await picker.getVideo(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

/*选择文件*/
  Future _fileUploader() async {
    FilePickerResult result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      setState(() {
        files = result.paths.map((path) => File(path)).toList();
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${_params['name']}'),
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RaisedButton.icon(
                  icon: Icon(Icons.search),
                  label: Text('查询'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  // onPressed: null,
                  onPressed: () {
                    print("查询数据");
                  },
                ),
                SizedBox(width: 10),
                RaisedButton(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text('插入'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    print("插入");
                  },
                ),
                SizedBox(width: 10),
                RaisedButton(
                  child: Text('清除'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    print("清除");
                  },
                ),
                SizedBox(width: 10),
                RaisedButton(
                  child: Text('修改'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  elevation: 20,
                  onPressed: () {
                    print("修改");
                  },
                ),
              ],
            ),
            Column(
              children: [Text('$files')],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // SizedBox(width: 400),
                RaisedButton.icon(
                    icon: Icon(Icons.search),
                    label: Text('批量插入'),
                    color: Colors.blue,
                    textColor: Colors.white,
                    // onPressed: null,
                    onPressed: () {
                      print("批量插入");
                    }),
                SizedBox(width: 10),
                RaisedButton(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text('事务控制'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    print("事务控制");
                  },
                ),
                SizedBox(width: 10),
                RaisedButton(
                  child: Text('点击上传'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _fileUploader();
                  },
                ),
              ],
            ),
            Center(
              child: Text('相册操作'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  padding: new EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                  child: Text('拍照'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _takePhoto();
                  },
                ),
                RaisedButton(
                  child: Text('打开相册'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _openGallery();
                  },
                ),
                RaisedButton(
                  child: Text('选取视频'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _getVideo();
                  },
                ),
                RaisedButton(
                  child: Text('拍摄视频'),
                  color: Colors.blue,
                  textColor: Colors.white,
                  onPressed: () {
                    _takeVideo();
                  },
                ),
              ],
            ),
            Expanded(
              child: Center(
                child: SizedBox(
                  width: 150.0,
                  height: 200.0,
                  child: _image == null
                      ? Text('No image selected.')
                      : Image.file(_image),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
