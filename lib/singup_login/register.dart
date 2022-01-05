import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/components/text_widget.dart';
import 'package:flutter_app_backend/pages/GridList.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {


  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();


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
                          icon:

                          Icon(Icons.arrow_back_ios, color:Color(0xFF000000)),
                          onPressed:()=>Navigator.of(context, rootNavigator: true).pop(context))
                    ],
                  ),
                ),
                SizedBox(height:height*0.05),
                TextWidget(text:"Register", fontSize:26, isUnderLine:false),
                TextWidget(text:"Your Self.", fontSize:26, isUnderLine:false),
                SizedBox(height:height*0.05),
                TextInput(textString:"Name", textController:nameController, hint:"Name"),
                SizedBox(height: height*.05,),
                TextInput(textString:"Email", textController:emailController, hint:"Email"),
                SizedBox(height: height*.05,),
                TextInput(textString:"Password", textController:passController, hint:"Password", obscureText: true,),
                SizedBox(height: height*.05,),
                TextInput(textString:"Conform password", textController:confPassController, hint:"Conform Password", obscureText: true,),
                SizedBox(height: height*.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(text:"Register", fontSize:22, isUnderLine:false),

                    GestureDetector(
                        onTap: (){
                          print(nameController.text);
                          print(emailController.text);
                          print(passController.text);
                          print(confPassController.text);
                          _register();
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
                          child: Icon(Icons.arrow_forward, color:Colors.white, size:25),
                        )
                    )
                  ],
                ),
                SizedBox(height:height*0.1),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        print("Sign in");
                      },
                      child:TextWidget(text:"Sign in", fontSize:16, isUnderLine:true),
                    ),
                  ],
                )
              ],
            ),
          )
      ),
    );
  }


  _register() async {
    var param = {
      'name' : nameController.text,
      'email' : emailController.text,
      'password' : passController.text,
      'password_confirmation' : confPassController.text,
    };

    var res = await CallApi().register('register', param);
    var body = json.decode(res.body);
    print(body);

    if(body['success']){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GridList()),
      );
       nameController.text = "";
       emailController.text = "" ;
       passController.text = "";
       confPassController.text = "";
    }else{
      _showMsg(body['message']);
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
