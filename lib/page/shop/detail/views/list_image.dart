import 'package:flutter/cupertino.dart';


class ShopDetailListImages extends StatefulWidget {
  const ShopDetailListImages(
      {super.key, required this.items,this.padding, this.physics});

  final List items;
  // final Widget Function(dynamic item) itemBuilder;

  final EdgeInsetsGeometry? padding;
  final ScrollPhysics? physics;

  @override
  State<ShopDetailListImages> createState() => _ListImagesState();
}

class _ListImagesState extends State<ShopDetailListImages> {

  late ValueNotifier<int> indexNotifier;

  @override
  void initState() {
    indexNotifier = ValueNotifier<int>(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
            child: ListView.separated(
              itemBuilder: (context, index) {
                final String val = widget.items.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    indexNotifier.value = index;
                  },
                  child: Image.network(
                    '${val.trim()}',
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                  // child: Image.network(
                  //   val,
                  //   key: ValueKey(val),
                  //   height: 120,
                  //   fit: BoxFit.fill,
                  // ),
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12,);
              }, itemCount: widget.items.length,
            )
        ),

        Expanded(
          flex: 8,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ValueListenableBuilder<int>(
                valueListenable: indexNotifier,
                builder: (_, value, child){
                  final String image = widget.items[value];
                  return Image.network(
                    image.trim(),
                    key: ValueKey(value),
                    fit: BoxFit.fill,
                  );
                }
            ),
          ),
        )
      ],
    );
  }
}
