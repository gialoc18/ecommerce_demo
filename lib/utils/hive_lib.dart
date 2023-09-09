import 'package:hive/hive.dart';

mixin HiveLib{
  // HiveLib();

  Box? box;

  init([String? storage]) async{
    box = await Hive.openBox(storage??'storage');
  }

  put(key,value) async{
    return await box?.put(key, value);
  }

  Future putAll(Map entries) async {
    return await  box!.putAll(entries);
  }

  Future putAt(int index, dynamic entries) async {
    return await box!.putAt(index,entries);
  }


  Future push(dynamic data) async {
    return await box!.add(data);
  }

  Future pushAll(Iterable<dynamic> entries) async {
    return await box!.addAll(entries);
  }

  dynamic get(key) {
    return box?.get(key);
  }

  dynamic getAt(int index) {
    return box?.getAt(index);
  }

  Future delete(String id) async {
    return await box?.delete(id);
  }

  Stream<BoxEvent>? watch(String id){
    return box?.watch(key: id);
  }

  Future deleteAtIndex(int index) async {
    return await box?.deleteAt(index);
  }

  Future clear() async {
    return await box?.clear();
  }

  List getValues(){
    return box!.values.toList();
  }

  List getKeys(){
    return box!.keys.toList();
  }

}
