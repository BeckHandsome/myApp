import 'dart:async';

import 'package:flutter/material.dart';

// 跑马灯
class MarqueeControlWidget extends StatefulWidget {
  Widget children;
  Axis axis;
  double stepOffset;
  Duration duration;
  MarqueeControlWidget({
    Key key,
    this.children,
    this.axis = Axis.horizontal,
    this.stepOffset = 100,
    this.duration = const Duration(seconds: 4),
  }) : super(key: key);
  _MarqueeControlWidgetState createState() => _MarqueeControlWidgetState();
}

class _MarqueeControlWidgetState extends State<MarqueeControlWidget> {
  ScrollController _controller;
  Timer _timer;
  double _offset = 0.0;
  void initState() {
    super.initState();
    _controller = ScrollController(initialScrollOffset: _offset);
    _timer = Timer.periodic(widget.duration, (timer) {
      double newOffset = _controller.offset + widget.stepOffset;
      if (newOffset != _offset) {
        _offset = newOffset;
        _controller.animateTo(_offset,
            duration: widget.duration, curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        scrollDirection: widget.axis,
        controller: _controller,
        itemBuilder: (context, index) => widget.children,
      ),
    );
  }
}
