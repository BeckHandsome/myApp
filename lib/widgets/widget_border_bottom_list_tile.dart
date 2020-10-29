import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BorderBottomListTileWidget extends StatelessWidget {
  BorderBottomListTileWidget({
    Key key,
    this.color = const Color(0xffEDEDED),
    this.icon = const Icon(Icons.keyboard_arrow_right),
    this.title,
    this.leading,
    this.onTap,
  }) : super(key: key);
  final Color color;
  final Icon icon;
  final Widget title;
  final Widget leading;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: color,
          ),
        ),
      ),
      child: ListTile(
        leading: leading,
        title: title,
        trailing: icon,
        onTap: () {
          if (onTap != null) onTap();
        },
      ),
    );
  }
}
