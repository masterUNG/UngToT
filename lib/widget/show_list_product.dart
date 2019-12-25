import 'package:flutter/material.dart';
import 'package:ungtot/models/user_model.dart';
import 'package:ungtot/scaffold/add_new_product.dart';

class ShowListProduct extends StatefulWidget {
  final UserModel userModel;
  ShowListProduct({Key key, this.userModel}):super(key:key);
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  // Field
  UserModel myUserModel;

  // Method
  @override
  void initState(){
    super.initState();
    myUserModel = widget.userModel;
  }

  Widget addProductButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  MaterialPageRoute materialPageRoute =
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return AddNewProduct(userModel: myUserModel,);
                  });
                  Navigator.of(context).push(materialPageRoute);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          addProductButton(),
        ],
      ),
    );
  }
}
