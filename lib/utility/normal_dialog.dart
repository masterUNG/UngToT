import 'package:flutter/material.dart';
import 'package:ungtot/utility/my_style.dart';

Widget showTitle(String title) {
  return ListTile(
    leading: Icon(
      Icons.add_alert,
      color: Colors.red,size: 48.0,
    ),
    title: Text(
      title,
      style: MyStyle().h2Style,
    ),
  );
}

Widget okButton(BuildContext buildContext) {
  return FlatButton(
    child: Text('OK'),
    onPressed: () {Navigator.of(buildContext).pop();},
  );
}

Future<void> normalDialog(
    BuildContext buildContext, String title, String message) async {
  showDialog(
      context: buildContext,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: showTitle(title),
          content: Text(message),
          actions: <Widget>[okButton(buildContext)],
        );
      });
}
