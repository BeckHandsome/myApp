import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

Future widgetPhotoView({@required BuildContext context, List dataList}) {
  Future<bool> requestPermission() async {
    var status = await Permission.photos.status;
    if (status.isUndetermined) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.photos,
      ].request();
    }
    return status.isGranted;
  }

  //保存网络图片到本地
  _savenNetworkImage(src) async {
    var status = await Permission.photos.status;
    if (status.isDenied) {
      // We didn't ask for permission yet.
      print('暂无相册权限');
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text('您当前没有开启相册权限'), actions: [
              FlatButton(
                child: Text('开启'),
                onPressed: () {
                  openAppSettings();
                },
              ),
            ]);
          });
      return;
    }
    var response = await Dio()
        .get(src, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: "hello");
    if (Platform.isIOS) {
      if (result) {
        Fluttertoast.showToast(msg: '保存成功', gravity: ToastGravity.CENTER);
      } else {
        Fluttertoast.showToast(msg: '保存失败', gravity: ToastGravity.CENTER);
      }
    } else {
      if (result != null) {
        Fluttertoast.showToast(msg: '保存成功', gravity: ToastGravity.CENTER);
      } else {
        Fluttertoast.showToast(msg: '保存失败', gravity: ToastGravity.CENTER);
      }
    }
  }

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        child: Stack(
          children: [
            PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext cxt, int i) {
                return PhotoViewGalleryPageOptions.customChild(
                  child: GestureDetector(
                    child: PhotoView(
                      imageProvider: NetworkImage("${dataList[i]}"),
                    ),
                    onLongPress: () {
                      showDialog(
                        context: cxt,
                        builder: (cxt) {
                          return AlertDialog(
                            content: GestureDetector(
                              child: Text('保存图片'),
                              onTap: () {
                                Navigator.of(cxt).pop();
                                if (Platform.isIOS) {
                                  return _savenNetworkImage(dataList[i]);
                                }
                                requestPermission().then((bool) {
                                  if (bool) {
                                    _savenNetworkImage(dataList[i]);
                                  }
                                });
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                  disableGestures: false,
                  // initialScale: PhotoViewComputedScale.contained * 0.8,
                  // heroAttributes: PhotoViewHeroAttributes(tag: i),
                );
              },
              itemCount: dataList.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes,
                  ),
                ),
              ),
            ),
            Positioned(
              //右上角关闭按钮
              right: 10,
              top: MediaQuery.of(context).padding.top,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
