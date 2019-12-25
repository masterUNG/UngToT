import 'package:flutter/material.dart';
import 'package:ungtot/models/user_model.dart';
import 'package:ungtot/utility/my_style.dart';
import 'package:ungtot/widget/show_infomation.dart';
import 'package:ungtot/widget/show_list_product.dart';

class MyService extends StatefulWidget {
  final UserModel userModel;
  MyService({Key key, this.userModel}) : super(key: key);

  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Field
  UserModel myUserModel;
  Widget currentWidget = ShowListProduct();

  // Method
  @override
  void initState() {
    super.initState();
    myUserModel = widget.userModel;
    print('NameLogin = ${myUserModel.name}');
  }

  Widget menuShowList() {
    return ListTile(onTap: (){
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

  Widget menuShowInfo() {
    return ListTile(onTap: (){
      setState(() {
        currentWidget = ShowInfomation();
      });
      Navigator.of(context).pop();
    },
      leading: Icon(Icons.filter_2),
      title: Text('Show Infomation'),
      subtitle: Text('Expand or Description Menu Infomation'),
    );
  }

  Widget menuShowQRcode() {
    return ListTile(
      leading: Icon(Icons.filter_3),
      title: Text('QR code and Bar Code'),
      subtitle: Text('Expand or Description Menu QR code and Bar Code'),
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
