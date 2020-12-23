import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetSwitch extends StatelessWidget {
  WidgetSwitch({
    Key key,
    this.leading,
    this.title,
    this.trailing,
    this.subtitle,
    this.activeColor,
    this.trackColor,
    @required this.switchValue,
    @required this.onChanged,
  }) : super(key: key);
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final bool switchValue;
  final Color activeColor;
  final Color trackColor;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: CupertinoSwitch(
        value: switchValue,
        trackColor: trackColor,
        activeColor: activeColor,
        onChanged: onChanged,
      ),
    );
  }
}
