import 'package:ecommerce_demo/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller.dart';
import 'views/item.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Provider.of<ShopController>(context);
    return Consumer<ShopController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Danh sách sản phẩm', style: Theme.of(context).textTheme.titleMedium),
            elevation: 0.5,
            centerTitle: true,
          ),
          body: Builder(
            builder: (context) {
              if(controller.items == null){
                return const Center(child: CupertinoActivityIndicator());
              }
              if(controller.items!.isNotEmpty){
                if(controller.items!.isEmpty){
                  return const Center(child: Text('Danh sách sản phẩm trống!'),);
                }
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      final Product item = controller.items!.elementAt(index);
                      return ShopItem(item: item,);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox();
                    },
                    itemCount: controller.items!.length
                );
              }
              return const SizedBox();
            },
          )

        );
      },
    );

  }
}
