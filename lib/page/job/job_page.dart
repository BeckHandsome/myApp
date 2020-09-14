import 'package:flutter/material.dart';
import 'package:my_app/tool/fluro_convert_util.dart';

// 招聘信息
class JobPage extends StatefulWidget {
  final Map<String, dynamic> params;
  JobPage({
    Key key,
    this.params,
  }) : super(key: key);
  _JobPageState createState() => _JobPageState();
}

class _JobPageState extends State<JobPage> {
  Map _params = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _params = FluroConvertUtils.fluroMapParamsDecode(widget.params);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('${_params['name']}'),
      ),
      body: Container(
        child: Text('${_params['name']}'),
      ),
    );
  }
}
