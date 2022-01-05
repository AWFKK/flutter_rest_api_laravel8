import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_backend/api/my_api.dart';
import 'package:flutter_app_backend/models/product.dart';
import 'package:flutter_app_backend/pages/add_product.dart';


class GridList extends StatefulWidget {
  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {

  List<Product> _product = [];


  @override
  void initState() {
    _productList();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Record"),
      ),
      body:Stack(
        children: [
          Container(
            child: ListView.builder(
                shrinkWrap: true,
                //physics: NeverScrollableScrollPhysics(),
                itemCount: _product.length,
                itemBuilder: (BuildContext context,int index){
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.all(
                          Radius.circular(10.0)
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: ListTile(
                        trailing: Text(_product[index].price,
                          style: TextStyle(
                              color: Colors.green,fontSize: 15),),
                        title:Text(_product[index].name)
                    ),
                  );
                }
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProduct()),
                );
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  shape:BoxShape.circle,
                  color:Colors.black,
                ),
                child: Icon(Icons.add, color:Colors.white, size:25),
              ),
            ),
          )
        ],
      ),

    );
  }

  //
  _productList() async {
    var res =  await CallApi().productList('products');
    setState(() {
      _product = res;
    });
  }


}
