import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/components/text_widget.dart';


class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController emailController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final double height= MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.only(left: 30, right: 40),
          child:SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height:height*0.1),
                Container(
                  padding: const EdgeInsets.only(left:0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          padding:EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(Icons.arrow_back_ios, color:Color(0xFF000000)),
                          onPressed:()=>Navigator.of(context, rootNavigator: true).pop(context))
                    ],
                  ),
                ),
                SizedBox(height:height*0.05),
                TextWidget(text:"Add New", fontSize:26, isUnderLine:false),
                TextWidget(text:"Product.", fontSize:26, isUnderLine:false),
                SizedBox(height:height*0.05),
                TextInput(textString:"Name", textController:slugController, hint:"Name"),
                SizedBox(height: height*.05,),
                TextInput(textString:"Slug", textController:emailController, hint:"Slug"),
                SizedBox(height: height*.05,),
                TextInput(textString:"Description", textController:descController, hint:"Description"),
                SizedBox(height: height*.05,),
                TextInput(textString:"Price", textController:priceController, hint:"Price"),
                SizedBox(height: height*.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text:"Product", fontSize:22, isUnderLine:false),

                    GestureDetector(
                        onTap: (){
                          _addProduct();
                        },
                        child:
                        Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape:BoxShape.circle,
                            color:Color(0xFF000000),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Icon(Icons.add, color:Colors.white, size:25),
                        )
                    )
                  ],
                ),
                SizedBox(height:height*0.1),
              ],
            ),
          )
      ),
    );
  }

  _addProduct() async {
    var param = {
      'name' : slugController.text,
      'slug' : emailController.text,
      'description' : descController.text,
      'price' : priceController.text,
    };

    var res = await CallApi().addProduct('products', param);
    print(res);

    if(res){
      setState(() {
        slugController.text = "";
        emailController.text = "" ;
        descController.text = "";
        priceController.text = "";
      });
    }else{
      _showMsg("Error...!");
    }

  }

  _showMsg(msg) { //
    final snackBar = SnackBar(
      backgroundColor: Color(0xFF000000),
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}


class TextInput extends StatelessWidget {
  final String textString;
  TextEditingController textController;
  final String hint;
  bool obscureText;
  TextInput({Key key, this.textString, this.textController, this.hint, this.obscureText=false}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Color(0xFF000000)),
      cursorColor: Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(

        hintText: this.textString,
        hintStyle: TextStyle(
            color: Color(0xFF9b9b9b),
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
