
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungtot/utility/my_style.dart';
import 'package:ungtot/utility/normal_dialog.dart';







class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file;
  String name, user, password, avatar;
  final formKey = GlobalKey<FormState>();

  // Method
  Widget nameForm() {
    Color color = Colors.purple;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: TextFormField(
            onSaved: (String string) {
              name = string.trim();
            },
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
            onSaved: (String string) {
              user = string.trim();
            },
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
            onSaved: (String string) {
              password = string.trim();
            },
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
      onPressed: () {
        formKey.currentState.save();

        if (file == null) {
          normalDialog(context, 'Non Choose Image',
              'Please Click Camera or Gallery for Choose Image');
        } else if (name.isEmpty) {
          normalDialog(context, 'Name Blank', 'Please Type Your Name');
        } else if (user.isEmpty) {
          normalDialog(context, 'User Blank', 'Please Type Your User');
        } else if (password.length <= 5) {
          normalDialog(context, 'Password Weak',
              'Please Type Password More 6 Charactor');
        } else {
          uploadPictureToServer();
        }
      },
    );
  }

  Future<void> uploadPictureToServer() async {
    Random random = Random();
    int i = random.nextInt(10000);
    String namePicture = 'avatar$i.jpg';
    print('namePicture = $namePicture');

    avatar = 'https://www.androidthai.in.th/tot/MasterUng/$namePicture';

    String urlAPI = 'https://www.androidthai.in.th/tot/saveFileMaster.php';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, namePicture);
      FormData formData = FormData.from(map);

      Response response = await Dio().post(urlAPI, data: formData);
      print('response = $response');

      var result = response.data;

      String string = result['message'];
      print('string = $string');

      if (string == 'File uploaded successfully') {
        insertDatatoMySQL();
      } else {
        print('Cannot Upload');
      }
    } catch (e) {}
  }

  Future<void> insertDatatoMySQL()async{

    String url = 'https://www.androidthai.in.th/tot/addDataMaster.php?isAdd=true&Name=$name&User=$user&Password=$password&Avatar=$avatar';

    Response response = await Dio().get(url);
    var result = response.data;
    print('result = $result');

    if (result.toString() == 'true') {
      Navigator.of(context).pop();
    } else {
      normalDialog(context, 'Cannot Register', 'Please Try Again');
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[registerButton()],
        backgroundColor: MyStyle().mainColor,
        title: Text('Register'),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          children: <Widget>[
            showAvatar(),
            showButton(),
            nameForm(),
            userForm(),
            passwordForm(),
          ],
        ),
      ),
    );
  }
}
