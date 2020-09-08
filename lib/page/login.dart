import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_app/routes/application.dart';
import 'package:my_app/tool/util.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey _formKey = new GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    geta();
  }

  sava() async {
    sharedAddAndUpdate('userName', String, _userNameController.text.toString());
    sharedAddAndUpdate('password', String, _passwordController.text.toString());
  }

  geta() async {
    _userNameController.text = sharedGetData('userName');
    _passwordController.text = sharedGetData('password');
  }

  _clickLogin() async {
    if (_passwordController.text == '123456' &&
        _userNameController.text == 'admin') {
      Fluttertoast.showToast(
        msg: "登录成功",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(int.parse('0x0cf000000')).withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Timer(Duration(seconds: 2), () {
        // pushNamedAndRemoveUntil用户已经登陆进入 HomeScreen ，然后经过一系列操作回到配合只界面想要退出登录，你不能够直接 Push 进入 LoginScreen 吧？你需要将之前路由中的实例全部删除是的用户不会在回到先前的路由中。pushNamedAndRemoveUntil 可实现该功能：Navigator.of(context).pushNamedAndRemoveUntil('/screen4', (Route<dynamic> route) => false);这里的 (Route<dynamic> route) => false 能够确保删除先前所有实例。
        // pushReplacementNamed：当用户成功登录并且现在在 HomeScreen 上时，您不希望用户还能够返回到 LoginScreen。因此，登录应完全由首页替换。另一个例子是从 SplashScreen 转到 HomeScreen。 它应该只显示一次，用户不能再从 HomeScreen 返回它。 在这种情况下，由于我们要进入一个全新的屏幕，我们可能需要借助此方法。Navigator.pushReplacementNamed(context,"/login",);
        Application.router
            .navigateTo(context, '/', replace: true, clearStack: true);
      });
    } else {
      Fluttertoast.showToast(
        msg: "用户名或者密码不正确",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Color(int.parse('0x0cf000000')).withOpacity(0.5),
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
          backgroundColor: Color(0xFF25304C),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            padding: EdgeInsets.all(30),
            child: Column(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white,
                      ),
                      child: SizedBox(
                        width: 180,
                        height: 180,
                        child: Placeholder(
                          fallbackWidth: 200,
                          fallbackHeight: 200,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _userNameController, //通过controller获取输入框内容
                        autofocus: false, //自动获取焦点
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          labelText: "用户名",
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: ("请输入用户名"),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                          prefixIcon:
                              Icon(Icons.person_outline, color: Colors.white),
                          hintStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        validator: (v) {
                          return v.trim().length > 0 ? null : "请输入用户名";
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            labelText: "密码",
                            labelStyle: TextStyle(color: Colors.white),
                            hintText: ("请输入密码"),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            prefixIcon:
                                Icon(Icons.person_outline, color: Colors.white),
                            hintStyle: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          validator: (v) {
                            return v.trim().length > 5 ? null : "密码不能少于6位";
                          },
                          onFieldSubmitted: (v) {
                            if ((_formKey.currentState as FormState)
                                .validate()) {
                              _clickLogin();
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: ConstrainedBox(
                          constraints: BoxConstraints.expand(height: 55),
                          child: RaisedButton(
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              print(_userNameController.text);
                              if ((_formKey.currentState as FormState)
                                  .validate()) {
                                _clickLogin();
                              }
                            },
                            textColor: Colors.white,
                            child: Text("登录"),
                          ),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 55),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            sava();
                          },
                          textColor: Colors.white,
                          child: Text("存储"),
                        ),
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 55),
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            geta();
                          },
                          textColor: Colors.white,
                          child: Text("读取"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          resizeToAvoidBottomPadding: false),
    );
  }
}
