import 'package:flutter/material.dart';
import 'package:ungtot/utility/my_style.dart';

class AddNewProduct extends StatefulWidget {
  @override
  _AddNewProductState createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  // Field

  // Method
  Widget nameForm() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Name Product :'),
    );
  }

  Widget detailForm() {
    return TextFormField(maxLines: 3,
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
      onPressed: () {},
    );
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(
        Icons.add_photo_alternate,
        size: 36.0,
      ),
      onPressed: () {},
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
      height: MediaQuery.of(context).size.height * 0.5,
      child: Image.asset('images/pic.png'),
    );
  }

  Widget mainContent() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showPicture(),
            showButton(),
            nameForm(),
            detailForm(),
          ],
        ),
      ),
    );
  }

  Widget uploadButton() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().mainColor,
        title: Text('Add New Product'),
      ),
      body: Stack(
        children: <Widget>[
          mainContent(),
        ],
      ),
    );
  }
}
