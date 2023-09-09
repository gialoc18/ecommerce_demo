import 'package:ecommerce_demo/global.dart';
import 'package:ecommerce_demo/models/product.dart';
import 'package:ecommerce_demo/utils/helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'controller.dart';
import 'package:provider/provider.dart';
import 'views/item.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartController>(
      create: (context) => CartController(),
      builder: (context, child) => _CartPage(),
    );
  }
}


class _CartPage extends StatelessWidget {
  const _CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Provider.of<CartController>(context);
    return Consumer<CartController>(
      builder: (context, controller, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Giỏ hàng', style: Theme.of(context).textTheme.titleMedium),
            elevation: 0.5,
            centerTitle: true,
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Builder(
                      builder: (context){
                        if(controller.products == null){
                          return const Center(child: CupertinoActivityIndicator(),);
                        }
                        if(empty(controller.products)){
                          return Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Bạn chưa có sản phẩm nào trong giỏ hàng',style: Theme.of(context).textTheme.labelSmall),
                              ],
                            ),
                          );
                        }
                        return ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.products!.length,
                          separatorBuilder: (context, index) {
                            return const SizedBox();
                          },
                          itemBuilder: (context, index) {
                            final Product item = controller.products!.elementAt(index);
                            return CartItem(
                              item,
                              onChange: (type, item) async{
                                return await controller.onChanged(type, item);
                              },
                              onDelete: (Map item) {
                                controller.deleteItem(item);
                              },
                              isSelected: (item){
                                return controller.isSelect(item);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                if(!empty(controller.products))
                  Card(
                    margin: EdgeInsets.zero,
                    elevation: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Divider(height: 0.5,),
                        const SizedBox(height: 12,),
                        Row(
                          children: [
                            Checkbox(
                                value: controller.isSelect({'id': 'all'}),
                                onChanged: (val) {
                                  controller.onChanged('selectAll', {'id': 'all'});
                                }
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: ()async{
                                },
                                child: Text.rich(
                                  TextSpan(
                                      text: 'Tổng thanh toán',
                                      children: [
                                        TextSpan(text: '\n${controller.getSelectedAmount()}',
                                            style: TextStyle(
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14
                                            )
                                        )
                                      ]
                                  ),
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 12
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            ElevatedButton(
                              onPressed: controller.productSelectedIds.isNotEmpty?()async {
                                showMessage('Bạn đã đặt hàng', type: 'SUCCESS');
                              }:null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: controller.productSelectedIds.isNotEmpty?Theme.of(context).primaryColor:null
                              ),
                              child: Text('${'Mua hàng'}'),
                            ),
                            const SizedBox(width: 10,)
                          ],
                        ),
                        const SizedBox(height: 12,),
                      ],
                    ),
                  )
              ],
            ),
          ),
        );
      },
    );
  }
}
