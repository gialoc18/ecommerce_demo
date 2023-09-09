import 'dart:convert';

import 'package:ecommerce_demo/utils/helper.dart';


class Product{
  String? id;
  String? title;
  String? price;
  String? oldPrice;
  String? thumbnail;
  List<String>? images;
  Map? types;
  String? brief;
  String? content;
  String? quality;

  Product({this.id, this.title, this.brief, this.images, this.content, this.oldPrice, this.price, this.quality, this.thumbnail, this.types});

  factory Product.formJson(Map json){
    return Product(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      brief: json['brief'],
      content: json['content'],
      price: json['price'].toString(),
      oldPrice: json['oldprice'].toString(),
      images: (!empty(json['images']))?json['images'].toString().split(',').toList():[],
      quality: json['quantity'].toString(),
      types: (!empty(json['types']))?jsonDecode(json['types']):{},
    );
  }

  Map<String, dynamic> toJson() => _categoryToJson(this);


  Map<String, dynamic> _categoryToJson(Product instance){
    return {
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'brief': instance.brief,
      'content': instance.content,
      'price': instance.price,
      'oldprice': instance.oldPrice,
      'images': instance.images,
      'quality': instance.quality,
      'types': instance.types,
    };
  }

  List<Product> toList(List list) {
    final List<Product> lists = <Product>[];
    for (Map element in list) {
      lists.add(Product.formJson(element));
    }
    return lists;
  }


  List<Product> formListJson(List list) {
    final List<Product> lists = <Product>[];
    for (Map element in list) {
      lists.add(Product.formJson(element));
    }
    return lists;
  }


  @override
  String toString() {
    return 'title: $title - id: $id';
  }

}