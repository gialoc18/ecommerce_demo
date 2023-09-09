import 'package:ecommerce_demo/global.dart';
import 'package:ecommerce_demo/utils/helper.dart';

class ToDoStorage{
  ToDoStorage._();
  static ToDoStorage get instance => ToDoStorage._();
  
  Map data = {};

  init() async{
    data = await storage.get('CartLocal')??{};
    if (!data.containsKey('products')) {
      data['products'] = <String, dynamic>{};
      data['totalAmount'] =  0;
    }else if(data.isEmpty){
      data = {
        'products': <String, dynamic>{},
        'totalAmount': 0
      };
    }
  }

  Future<Map> select() async{
    final Map res = await storage.get('CartLocal')??{};
    data = res;
    return res;
  }


  save() async{
    await storage.put('CartLocal', data);
  }

  clear() async{
    await storage.delete('CartLocal');
  }

  delete(String id, {Function(Map)? callback}) async{

    try {
      data.remove(id);
      await save();
      if (callback != null) {
        callback({'status': 'SUCCESS'});
      }
    }catch (e){
      if(callback != null){
        callback({'status': 'FAIL'});
      }
    }
  }

  edit(Map options, {Function(Map response)? callback, bool remove = false}) async{
    assert(!empty(options['id']), "id not found");
    assert(!empty(options['title']), "title not found");
    assert(!empty(options['price']), "price not found");
    assert(!empty(options['quantity']), "quantity not found");
    await init();
    String id = options['id'];
    try{
      if(remove){
        data['totalAmount'] = (data['totalAmount']??0) - (double.parse(options['price'].toString()));
      }else{
        data['totalAmount'] = (data['totalAmount']??0) + (int.parse(options['quantity'].toString()) * double.parse(options['price'].toString()));
      }
      if(data['products'] is Map && data['products'].containsKey(id)){
        if(remove){
          options['quantity'] = int.parse(options['quantity'].toString()) - 1;
          data['products'][id]['totalAmount'] = (data['products'][id]['totalAmount'] ?? 0) - (1* double.parse(options['price']));
        }else{
          options['quantity'] = int.parse(options['quantity'].toString()) + int.parse(data['products'][id]['quantity'].toString());
          data['products'][id]['totalAmount'] = (data['products'][id]['totalAmount'] ?? 0) + (int.parse(options['quantity'].toSting())* double.parse(options['price'].toString()));
        }
      }
      if(data['products'] is Map && data['products'].containsKey(id)){
        data['products'][id]['quantity'] = int.parse(options['quantity'].toSting());
      }else{
        options['time'] = time();
        options['quantity'] = 1;
        options['totalAmount'] = (1* double.parse(options['price'].toString()));
        data['products'].addAll(<String, dynamic>{
          id: options
        });
      }
      await save();
      if(callback != null){
        callback({'status': 'SUCCESS', 'id': id});
      }
    }catch (e){
      print(e.toString());
      if(callback != null){
        callback({'status': 'FAIL','id': id});
      }
    }
  }

  deleteAt(String id, {Function(Map)? callback, bool remove = false}) async{
    if(!empty(data)){
      for(var value in data.values){
        if(id == value['id'].toString()){
          value.addAll({
            'removeSelectedNow': remove?'':'1'
          });
          break;
        }
      }
      try{
        await save();
        if(callback != null){
          return await callback({'status': 'SUCCESS'});
        }
      }catch (e){
        if(callback != null){
          return await callback({'status': 'FAIL'});
        }
      }
    }else{
      if(callback != null) {
        return await callback({'status': 'FAIL'});
      }
    }
  }

  changeQuantity(Map options, {Function(Map response)? callback})async{
    bool isRemove = false;
    if(empty(options['remove'])){
      isRemove = true;
    }
    if(empty(options['id'])){
      options['id'] = options['id']??options['itemId'];
    }
    assert(!empty(options['id']));
    await init();
    String key = options['id'];
    if(data['products'] is Map && (data['products'] as Map).containsKey(key)){
      if(int.parse(data['products'][key]['quantity'].toString()) == int.parse(options['quantity'].toString())){
        return;
      }else if(int.parse(data['products'][key]['quantity'].toString()) == 0){
        await remove(options, callback: callback);
      }else if(isRemove){
        return await edit(options, callback: callback, remove: isRemove);
      }else{
        data['products'][key]['quantity'] = int.parse(options['quantity'].toString());
        data['products'][key]['totalAmount'] = (int.parse(options['quantity'].toString())* double.parse(options['price'].toString()));
        await save();
        if(callback != null){
          return await callback({
            'status': 'SUCCESS'
          });
        }
      }
    }else{
      return await edit(options, callback: callback);
    }
  }

  remove(Map options, {Function(Map response)? callback})async{
    assert(!empty(options['id']));
    await init();
    String key = (options['id']);
    if(data['products'] is Map && data['products'].containsKey(key)){
      data['totalAmount'] -= data['products'][key]['totalAmount'];
      data['products'].remove(key);

      if(callback != null){
        await callback({
          'status': 'SUCCESS'
        });
      }
      await save();
      return true;
    }else{
      return false;
    }
  }

}