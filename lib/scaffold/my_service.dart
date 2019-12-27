import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ungtot/models/user_model.dart';
import 'package:ungtot/scaffold/authen.dart';
import 'package:ungtot/scaffold/webview_youtube.dart';
import 'package:ungtot/utility/my_style.dart';
import 'package:ungtot/widget/list_video.dart';
import 'package:ungtot/widget/show_list_product.dart';
import 'package:vibration/vibration.dart';

class MyService extends StatefulWidget {
  final UserModel userModel;
  MyService({Key key, this.userModel}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Field
  UserModel myUserModel;
  Widget currentWidget;

  // Method
  @override
  void initState() {
    super.initState();
    myUserModel = widget.userModel;
    print('NameLogin = ${myUserModel.name}');
    currentWidget = ShowListProduct(
      userModel: myUserModel,
    );
  }

  Widget menuVibration() {
    return ListTile(
      onTap: () {
        Vibration.vibrate(duration: 2000);
        Navigator.of(context).pop();
      },
      leading: Icon(Icons.vibration),
      title: Text('Vibration'),
      subtitle: Text('Test Vibration'),
    );
  }

  Widget menuShowList() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ShowListProduct();
        });
        Navigator.of(context).pop();
      },
      leading: Icon(Icons.filter_1),
      title: Text('Show List Product'),
      subtitle: Text('Expand or Description Menu Show List Product'),
    );
  }

  Widget menuSignOut() {
    return ListTile(
      onTap: () {
        signOutProcess();
      },
      leading: Icon(Icons.exit_to_app),
      title: Text('Sign Out'),
      subtitle: Text('Expand or Description Sign Out'),
    );
  }

  Future<void> signOutProcess()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    // Exit App Only
    // exit(0);

    // Back to Authen Page
    MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext buildContext){return Authen();});
    Navigator.of(context).pushAndRemoveUntil(materialPageRoute, (Route<dynamic> route){return false;});
  }

  Widget menuShowInfo() {
    return ListTile(
      onTap: () {
        setState(() {
          currentWidget = ListVideo();
        });
        Navigator.of(context).pop();
      },
      leading: Icon(Icons.video_call),
      title: Text('List Video'),
      subtitle: Text('Expand ListVideo'),
    );
  }

  Widget menuShowQRcode() {
    return ListTile(
      onTap: () {
        MaterialPageRoute materialPageRoute = MaterialPageRoute(
            builder: (BuildContext buildContext) => WebViewYouTube());
        Navigator.of(context).push(materialPageRoute);
      },
      leading: Icon(Icons.ondemand_video),
      title: Text('You Tube'),
      subtitle: Text('Show WebView on YouTube'),
    );
  }

  Widget showNameLogin() {
    return Text(
      'Login by ${myUserModel.name}',
      style: MyStyle().h2Style,
    );
  }

  Widget showAvatar() {
    return Container(
      width: 100.0,
      height: 100.0,
      child: ClipOval(
        child: Image.network(
          myUserModel.avatar,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget showHeadDrawer() {
    return DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/wall.jpg'), fit: BoxFit.cover),
      ),
      child: Column(
        children: <Widget>[
          showAvatar(),
          showNameLogin(),
        ],
      ),
    );
  }

  Widget showDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          showHeadDrawer(),
          menuShowList(),
          Divider(),
          menuShowInfo(),
          Divider(),
          menuShowQRcode(),
          Divider(),
          menuVibration(),
          Divider(),
          menuSignOut(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: showDrawer(),
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: Text('My Service'),
      ),
      body: currentWidget,
    );
  }
}
