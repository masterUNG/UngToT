import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ungtot/models/user_model.dart';
import 'package:ungtot/scaffold/my_service.dart';
import 'package:ungtot/scaffold/register.dart';
import 'package:ungtot/utility/my_style.dart';
import 'package:ungtot/utility/normal_dialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field
  String user, password;
  final formKey = GlobalKey<FormState>();

  // Method
  Widget mySizeBox() {
    return SizedBox(
      width: 5.0,
      height: 16.0,
    );
  }

  Widget signInButton() {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      color: MyStyle().mainColor,
      child: Text(
        'Sign In',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        formKey.currentState.save();

        if (user.isEmpty || password.isEmpty) {
          normalDialog(context, 'Have Space', 'Please Fill All Every Blank');
        } else {
          checkAuthenGetType();
          // checkAuthenPostType();
        }
      },
    );
  }

  Future<void> checkAuthenPostType() async {
    String url = 'http://iservice.totinnovate.com/WebAPI/LoginPost';
    Map<String, dynamic> map = Map();
    map['UserName'] = user;
    map['Password'] = password;

    Response response = await Dio().post(url, data: map);
    print('response =====>>> $response');
  }

  Future<void> checkAuthenGetType() async {
    String url =
        'https://www.androidthai.in.th/tot/getUserWhereUserMaster.php?isAdd=true&User=$user';

    Response response = await Dio().get(url);
    var result = json.decode(response.data);
    print('result ==============>>>>>>>> $result');

    if (result.toString() == 'null') {
      normalDialog(context, 'User False', 'No $user in my Database');
    } else {
      for (var map in result) {
        UserModel userModel = UserModel.fromJSON(map);
        if (password == userModel.password) {
          print('Welcome ${userModel.name}');

          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext buildContext) {
            return MyService(
              userModel: userModel,
            );
          });
          Navigator.of(context).pushAndRemoveUntil(materialPageRoute,
              (Route<dynamic> route) {
            return false;
          });
        } else {
          normalDialog(
              context, 'Password False', 'Please Try Agains Password False');
        }
      }
    }
  }

  Widget signUpButton() {
    return OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Text('Sign Up'),
      onPressed: () {
        print('You Click Sign Up');

        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext buildContext) {
          return Register();
        });
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        mySizeBox(),
        signUpButton(),
      ],
    );
  }

  Widget userForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        onSaved: (String string) {
          user = string.trim();
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().textColor)),
          hintText: 'User :',
        ),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: TextFormField(
        onSaved: (String string) {
          password = string.trim();
        },
        obscureText: true,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: MyStyle().textColor)),
          hintText: 'Password :',
        ),
      ),
    );
  }

  Widget showLogo() {
    return Container(
      width: 120.0,
      height: 120.0,
      child: Image.asset('images/logo.png'),
    );
  }

  Widget showAppName() {
    return Text(
      'Ung ToT',
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,
        color: MyStyle().textColor,
        fontFamily: 'Lobster',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: <Color>[Colors.white, Colors.blue.shade700],
            radius: 1.0,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  showLogo(),
                  mySizeBox(),
                  showAppName(),
                  mySizeBox(),
                  userForm(),
                  mySizeBox(),
                  passwordForm(),
                  showButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
