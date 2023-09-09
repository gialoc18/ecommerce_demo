import 'package:ecommerce_demo/global.dart';
import 'package:ecommerce_demo/models/product.dart';
import 'package:ecommerce_demo/routers.dart';
import 'package:ecommerce_demo/services/todo_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'views/list_image.dart';

class ShopDetailPage extends StatelessWidget {
  final Product item;
  const ShopDetailPage({super.key,required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(item.title??'', style: Theme.of(context).textTheme.titleMedium),
        elevation: 0.5,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                  child:  ShopDetailListImages(
                    items: item.images!,
                  )),
              Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text('${item.title}', style: Theme.of(context).textTheme.titleMedium),
                      ),
                      Text(
                        '${item.price}',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Color(0xff1479C7),
                        ),
                      ),
                      Html(
                        data: """${item.content}""",
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            await ToDoStorage.instance.edit({
                              'id': item.id,
                              'title': item.title,
                              'price': item.price,
                              'quantity': item.quality??1,
                              'thumbnail': item.thumbnail,
                            },callback: (response) {
                              if(response['status'] == 'SUCCESS'){
                                showMessage('Thêm vào giỏ hàng thành công',type: 'SUCCESS');
                                Navigator.pushNamed(context, AppRoutes.cart);
                              }else{
                                showMessage('Thêm vào giỏ hàng thất bại',type: 'ERROR');
                              }
                            },);
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xff304CB2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            "Thêm vào giỏ hàng",
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
