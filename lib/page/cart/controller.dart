import 'package:ecommerce_demo/models/product.dart';
import 'package:ecommerce_demo/services/todo_storage.dart';
import 'package:ecommerce_demo/utils/helper.dart';
import 'package:flutter/cupertino.dart';

class CartController extends ChangeNotifier{
  CartController(){
    _init();
  }
  List<Product>? products;

  Map carts = {};

  var selects = <String, dynamic>{};
  List productSelectedIds = [];

  bool hasInit = false;
  Map paramsOrder = {};



  _init() async{
    final res = await ToDoStorage.instance.select();
    carts = res;
    products = !empty(res['products'])?Product().toList(res['products'].values.toList()):[];
    // _setIds();
    notifyListeners();
  }
  // _setIds()async{
  //   productSelectedIds = carts['products'].keys.toList();
  //   // await setParamsOrder();
  //   // notifyListeners();
  // }


  getKey(Map options){
    return options['id']??'';
  }

  double getSelectedAmount(){
    return paramsOrder['totalAmount']??0;
  }

  Future<dynamic> onChanged(String type, Map item) async{
    switch(type){
      case 'select':
        if(isSelect(item)){
          productSelectedIds.remove(getKey(item));
        }else{
          productSelectedIds.add(getKey(item));
        }
        await setParamsOrder();
        notifyListeners();
        break;
      case 'selectAll':
        if(isSelect(item)){
          productSelectedIds = [];
        }else{
          productSelectedIds = [...carts['products'].keys];
        }
        await setParamsOrder();
        notifyListeners();
        break;
      case 'changeQuantity':
        await ToDoStorage.instance.changeQuantity(item,callback: (response) async{
          await setParamsOrder();
          notifyListeners();
        },);
        break;

    }
  }

  bool isSelect(Map item){
    if(!empty(productSelectedIds)){
      if(item['id'] == 'all'){
        return productSelectedIds.length == products!.length;
      }else{
        return productSelectedIds.contains(getKey(item));
      }
    }
    return false;
  }

  void deleteItem(Map item) async{
    final res = await ToDoStorage.instance.remove(item);
    if (res == true) {
      await _init();
    }
  }

  setParamsOrder() async{
    await getProductOrder(productSelectedIds, callback: (response) {
      paramsOrder = response;
    },);
  }

  getProductOrder(List ids, {Function(Map response)? callback}) async{
    Map params = {};
    await _init();
    // params = cartController.cartLocal.cart;
    double total = 0;
    // List _products = [];
    // Map items = {};
    for (var element in ids) {
      if(carts['products'].containsKey(element)){
        // items.addAll(products[element]);
        total += carts['products'][element]['totalAmount']??0;
        // _products.add(items);
      }
    }
    params['totalAmount'] = total;
    params['products'] = carts['products'].values.toList();
    if(callback != null){
      await callback(params);
    }
  }
}