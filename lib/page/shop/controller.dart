import 'dart:convert';
import 'package:ecommerce_demo/models/product.dart';
import 'package:ecommerce_demo/services/http_service.dart';
import 'package:ecommerce_demo/utils/helper.dart';
import 'package:flutter/material.dart';


class ShopController extends ChangeNotifier{

  ShopController(){
    selectAll();
  }

  List<Product>? items;

  HttpService httpService = HttpService();

  selectAll({String? categoryId}) async{
    final  res = await httpService.get(
      body: {
        'action': 'selectAll',
        'sheetName': 'Product',
        'pageSize': '1000',
      },
    );
    if(!empty(res.body)){
      final data = jsonDecode(res.body) as Map;
      if(!empty(data['data'])){
        items =  Product().formListJson(data['data']);
        notifyListeners();
      }
    }
  }
}