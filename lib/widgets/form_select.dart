import 'package:flutter/material.dart';
import 'package:ecommerce_demo/utils/extension/ex_string.dart';

class FormSelect extends StatefulWidget {
  final String title;
  final List items;
  final Widget Function(dynamic val)? builder;
  final Widget Function(VoidCallback voidCallback)? generateBuilder;
  final Widget? trailing;
  final ValueChanged? onChange;
  final String? value;
  final bool fullHeight;
  const FormSelect({required this.title,this.generateBuilder,this.fullHeight = false, required this.items, this.builder, this.trailing, this.onChange, this.value, Key? key}) : super(key: key);

  @override
  State<FormSelect> createState() => _FormSelectState();
}

class _FormSelectState extends State<FormSelect> {
  String? _value;

  ValueNotifier<String> currentVal = ValueNotifier('');

  @override
  void initState() {
    _value = widget.value;
    currentVal.value = _value??'';
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormSelect oldWidget) {

    if(currentVal.value != widget.value){
      _value = currentVal.value;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    if(widget.generateBuilder != null){
      return widget.generateBuilder!(
          _showBottom
      );
    }
    return ListTile(
      onTap: _showBottom,
      title: Text(widget.title.lang(context)),
      trailing: widget.trailing,
    );
  }

  _showBottom(){
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: widget.fullHeight,
      builder: (_) {
        return ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: widget.items.map((e) {
            return ValueListenableBuilder(
                valueListenable: currentVal,
                builder: (context, val, child) {
                  if(widget.builder != null) {
                    return widget.builder!(e);
                  }
                  return ListTile(
                    onTap: () {
                      onChange(e['code']);
                    },
                    leading: Icon(isCheck(e['code']) ? Icons.check_circle : Icons.circle_outlined),
                    title: Text(e['title']),
                  );
                }
            );
          }).toList(),
        );
      },
    );
  }

  onChange(e){
      setState(() {
        currentVal.value = e;
        if(widget.onChange != null) widget.onChange!(e);
      });
  }

  bool isCheck(val) => val == currentVal.value;


}
