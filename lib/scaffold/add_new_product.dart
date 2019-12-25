import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ungtot/models/user_model.dart';
import 'package:ungtot/utility/my_style.dart';
import 'package:ungtot/utility/normal_dialog.dart';

class AddNewProduct extends StatefulWidget {
  final UserModel userModel;
  AddNewProduct({Key key, this.userModel}) : super(key: key);
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  // Field
  File file;
  String product, detail, path, post, code;
  final formKey = GlobalKey<FormState>();
  UserModel myUsermodel;

  // Method
  @override
  void initState() {
    super.initState();
    myUsermodel = widget.userModel;
    post = myUsermodel.name;
  }

  Widget nameForm() {
    return TextFormField(
      onSaved: (String string) {
        product = string.trim();
      },
      decoration: InputDecoration(labelText: 'Name Product :'),
    );
  }

  Widget detailForm() {
    return TextFormField(
      onSaved: (String string) {
        detail = string.trim();
      },
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(labelText: 'Detail Product :'),
    );
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(
        Icons.add_a_photo,
        size: 36.0,
      ),
      onPressed: () {
        getPicture(ImageSource.camera);
      },
    );
  }

  Future<void> getPicture(ImageSource imageSource) async {
    var object = await ImagePicker.pickImage(
        source: imageSource, maxWidth: 800.0, maxHeight: 600.0);

    setState(() {
      file = object;
    });
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
      ),
      onPressed: () {
        getPicture(ImageSource.gallery);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        cameraButton(),
        galleryButton(),
      ],
    );
  }

  Widget showPicture() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: file == null ? Image.asset('images/pic.png') : Image.file(file),
    );
  }

  Widget mainContent() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              showPicture(),
              showButton(),
              nameForm(),
              detailForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget uploadButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Text('Upload Value To Server'),
            onPressed: () {
              formKey.currentState.save();
              if (file == null) {
                normalDialog(context, 'Non Choose Picture',
                    'Please Click Camera or Gallery');
              } else if (product.isEmpty || detail.isEmpty) {
                normalDialog(context, 'Have Space', 'Please Fill Every Blank');
              } else {
                uploadPicture();
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> uploadPicture() async {
    String url = 'https://www.androidthai.in.th/tot/savePicture.php';

    Random random = Random();
    int i = random.nextInt(10000);
    String namePicture = 'pic$i.jpg';
    path = 'https://www.androidthai.in.th/tot/Product/$namePicture';
    code = 'code$i';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, namePicture);
      FormData formData = FormData.from(map);
      await Dio().post(url, data: formData).then((object) {
        print('Success Upload Picture');
        insertProductToMySQL();
      });
    } catch (e) {}
  }

  Future<void> insertProductToMySQL()async{

    String url = 'https://www.androidthai.in.th/tot/addProductMaster.php?isAdd=true&Product=$product&Detail=$detail&Path=$path&Post=$post&Code=$code';

    Response response = await Dio().get(url);
    var result = response.data;
    if (result.toString() == 'true') {
      Navigator.of(context).pop();
    } else {
      normalDialog(context, 'Insert False', 'Please Try Agains');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: Text('Add New Product'),
      ),
      body: Stack(
        children: <Widget>[
          uploadButton(),
          mainContent(),
        ],
      ),
    );
  }
}
