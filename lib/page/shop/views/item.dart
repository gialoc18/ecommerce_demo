import 'package:ecommerce_demo/global.dart';
import 'package:ecommerce_demo/models/product.dart';
import 'package:ecommerce_demo/routers.dart';
import 'package:ecommerce_demo/services/todo_storage.dart';
import 'package:flutter/material.dart';

class ShopItem extends StatelessWidget {
  final Product item;
  const ShopItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.detailProduct,arguments: item);
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          children: [
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: item.thumbnail != null?Image.network(
                  '${item.thumbnail}',
                  height: 120,
                  width: 120,
                  fit: BoxFit.fill,
                ): const SizedBox(
                  height: 120,
                  width: 120,
                  child: Text('no image'),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${item.title}',style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, maxLines: 2,
                    ),
                    const SizedBox(height: 12,),
                    Text('${item.price}',style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(height: 12,),
                    InkWell(
                      onTap: () async{
                        await ToDoStorage.instance.edit({
                          'id': item.id,
                          'title': item.title,
                          'price': item.price,
                          'quantity': item.quality??1,
                          'thumbnail': item.thumbnail,
                        },callback: (response) {
                          if(response['status'] == 'SUCCESS'){
                            showMessage('Thêm vào giỏ hàng thành công',type: 'SUCCESS');
                          }else{
                            showMessage('Thêm vào giỏ hàng thất bại',type: 'ERROR');
                          }
                        },);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          border: Border.all(
                            width: 1,

                          ),
                        ),
                        child: const FittedBox(
                          child: Text(
                            'Thêm vào giỏ hàng',
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}