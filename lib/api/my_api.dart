import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_backend/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class CallApi{

  //For Emulator
  final String _url = 'http://10.0.2.2:8000/api/';

  final String _imgUrl='http://mark.dbestech.com/uploads/';
  getImage(){
    return _imgUrl;
  }


  login(String strUrl, dynamic param) async {
    print("Url==> ${_url+strUrl}");
    return await http.post(
        Uri.parse(_url+strUrl),
        body: jsonEncode(param),
        headers: _setHeaders()
    );
  }

  //Register
  register(String strUrl, dynamic param) async {
    print("Url==> ${_url+strUrl}");
    return await http.post(
        Uri.parse(_url+strUrl),
        body: jsonEncode(param),
        headers: _setHeaders()
    );
  }


  //Get All Product
  Future<List<Product>> productList(String strUrl) async {
    print("Url==> ${_url+strUrl}");
    List<Product> prodList = [];
    http.Response response = await http.get(
        Uri.parse(_url+strUrl),
        //body: jsonEncode(param),
        headers: _setHeaders()
    );
    if(response.statusCode == 200){
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var jsonList = jsonDecode(response.body);
      for(var prod in jsonList){
        prodList.add(Product.fromJson(prod));
      }
      return prodList;
    }else {
      throw Exception('No Data Found');
    }
  }


  //Add New Product
  Future<bool> addProduct(String strUrl, dynamic param) async {
    Product _product;
    http.Response response = await http.post(
        Uri.parse(_url+strUrl),
        body: jsonEncode(param),
        headers: _setHeaders()
    );
    if(response.statusCode == 200){
      var result = json.decode(response.body);
      print("Result ${result['success']}");
      return result['success'];
    }else{
      return false;
    }
  }


  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return '?token=$token';
  }



  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
  };


}