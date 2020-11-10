import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackTop extends StatefulWidget {
  const BackTop({
    Key key,
    @required this.child,
    @required this.controller,
  }) : super(key: key);

  final Widget child;
  final ScrollController controller;
  _BackTopState createState() => _BackTopState();
}

class _BackTopState extends State<BackTop> {
  ScrollController _controller = ScrollController();
  bool _showToTopBtn = false;
  double _bottom = 30; //距顶部的偏移
  double _right = 20; //距左边的偏移
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = widget.controller;
    _controller.addListener(() {
      if (_controller.offset < 1000 && _showToTopBtn) {
        setState(() {
          _showToTopBtn = false;
        });
      } else if (_controller.offset >= 1000 && _showToTopBtn == false) {
        setState(() {
          _showToTopBtn = true;
        });
      }
    });
  }

  @override
  void dispose() {
    //为了避免内存泄露，需要调用_controller.dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: widget.child,
        ),
        _showToTopBtn
            ? Positioned(
                child: GestureDetector(
                  onTap: () {
                    _controller.animateTo(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.ease);
                  },
                  //手指按下时会触发此回调
                  onPanDown: (DragDownDetails e) {
                    //打印手指按下的位置(相对于屏幕)
                    print("用户手指按下：${e.globalPosition}");
                  },
                  //手指滑动时会触发此回调
                  onPanUpdate: (DragUpdateDetails e) {
                    //用户手指滑动时，更新偏移，重新构建
                    setState(() {
                      _right -= e.delta.dx;
                      _bottom -= e.delta.dy;
                    });
                  },
                  onPanEnd: (DragEndDetails e) {
                    //打印滑动结束时在x、y轴上的速度
                    print(e.velocity);
                  },
                  child: Opacity(
                    opacity: 0.5,
                    child: CircleAvatar(
                      backgroundColor: Colors.blue,
                      radius: 20,
                      child: Icon(
                        Icons.arrow_upward,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                bottom: _bottom,
                right: _right,
              )
            : Text(''),
      ],
    );
  }
}
