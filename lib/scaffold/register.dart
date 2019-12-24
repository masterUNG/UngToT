import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungtot/utility/my_style.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file;

  // Method
  Widget nameForm() {
    Color color = Colors.purple;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'English Only',
              helperText: 'Type Your Name in Blank',
              helperStyle: TextStyle(color: color),
              labelText: 'Name :',
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.account_box,
                size: 36.0,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget userForm() {
    Color color = Colors.green.shade900;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'English Only',
              helperText: 'Type Your User in Blank',
              helperStyle: TextStyle(color: color),
              labelText: 'User :',
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.email,
                size: 36.0,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget passwordForm() {
    Color color = Colors.orange.shade900;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            decoration: InputDecoration(
              hintText: 'more 6 Charactor',
              helperText: 'Type Your Password in Blank',
              helperStyle: TextStyle(color: color),
              labelText: 'Password :',
              labelStyle: TextStyle(color: color),
              icon: Icon(
                Icons.lock,
                size: 36.0,
                color: color,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget cameraButton() {
    return OutlineButton.icon(
      icon: Icon(Icons.add_a_photo),
      label: Text('Camera'),
      onPressed: () {
        cameraAndGalleryThread(ImageSource.camera);
      },
    );
  }

  Future<void> cameraAndGalleryThread(ImageSource imageSource) async {
    var object = await ImagePicker.pickImage(
      source: imageSource,
      maxWidth: 800.0,
      maxHeight: 600.0,
    );

    setState(() {
      file = object;
    });
  }

  Widget galleryButton() {
    return OutlineButton.icon(
      icon: Icon(Icons.add_photo_alternate),
      label: Text('Gallery'),
      onPressed: () {
        cameraAndGalleryThread(ImageSource.gallery);
      },
    );
  }
  

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showAvatar() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.9,
      child: file == null
          ? Image.asset(
              'images/avatar.png',
              fit: BoxFit.contain,
            )
          : Image.file(file),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      tooltip: 'Upload to Server',
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        backgroundColor: MyStyle().mainColor,
        title: Text('Register'),
      ),
      body: ListView(
        children: <Widget>[
          showAvatar(),
          showButton(),
          nameForm(),
          userForm(),
          passwordForm(),
        ],
      ),
    );
  }
}
