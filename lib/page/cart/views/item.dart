import 'package:ecommerce_demo/models/product.dart';
import 'package:ecommerce_demo/utils/helper.dart';
import 'package:ecommerce_demo/widgets/form_up_down.dart';
import 'package:flutter/material.dart';

class CartItem extends StatefulWidget {
  final Product item;
  final Function(String type, Map item) onChange;
  final Function(Map item) onDelete;
  final bool Function(Map item) isSelected;

  const CartItem(
      this.item, {
        Key? key,
        required this.onChange,
        required this.onDelete,
        required this.isSelected,
      }) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  String key = '${time()}';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
          vertical: 5.0, horizontal: 4.0),
      padding: const EdgeInsets.symmetric(
          vertical: 15.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18.0),
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            width: 15,
            child: Checkbox(
              value: widget.isSelected(widget.item.toJson()),
              onChanged: (val) async {
                await widget.onChange('select', widget.item.toJson());
                if (mounted) {
                  setState(() {});
                }
              },
            ),
          ),
          Flexible(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18.0),
              child: Image.network(
                widget.item.thumbnail?.trim()??'',
                key: ValueKey(widget.item.thumbnail),
                height: 80,
                width: 80,
                fit: BoxFit.fill,
                ),
            ),
          ),
          const SizedBox(width: 12,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.item.title??'',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontSize: 14.0)),
                const SizedBox(height: 12,),
                Text(
                  widget.item.price.toString(),
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                      fontSize: 16.0, fontWeight: FontWeight.w800),
                ),
                Row(
                  children: [
                    const Icon(Icons.close, size: 18.0),
                    Text(widget.item.quality??''),
                  ],
                ),
                const SizedBox(height: 12,),
                FormUpDown(
                  value: widget.item.quality != null ?int.parse(widget.item.quality.toString()): 1,
                  onChanged: (value) async {
                    if (value > 0) {

                      final res = await widget.onChange('changeQuantity', {
                        'quantity': value.toInt(),
                        'price': double.parse(widget.item.price??'0'),
                        'remove': int.parse(widget.item.quality??'1') > value.toInt(),
                        'id': widget.item.id,
                      });
                      if (mounted && ((res is Map && res['status'] == 'FAIL') || res == null)) {
                        key = '${time()}';
                        setState(() {});
                      }
                    } else {
                      widget.onDelete(widget.item.toJson());
                    }
                  },
                  min: 0,
                  max: 1000,
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
