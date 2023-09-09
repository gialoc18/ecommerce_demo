import 'package:flutter/material.dart';

class TextFieldDialog extends StatefulWidget {
  final String? value;
  final void Function(String)? onChanged;
  final void Function(String)? done;

  const TextFieldDialog({Key? key, this.onChanged, this.done, this.value}) : super(key: key);

  @override
  State<TextFieldDialog> createState() => _EditTextDialogState();
}

class _EditTextDialogState extends State<TextFieldDialog> {
  late TextEditingController _textEditingController;
  String? value;

  @override
  void initState() {
    super.initState();
    value = widget.value ?? '';
    _textEditingController = TextEditingController(text: value??'');
  }

  @override
  void didUpdateWidget(covariant TextFieldDialog oldWidget) {
    if(widget.value != value && oldWidget.value != widget.value){
      _textEditingController.text = widget.value!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.done?.call(_textEditingController.text);
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: true,
        body: Container(
          alignment: Alignment.bottomCenter,
          child: TextFormField(
            controller: _textEditingController,
            onChanged: (val){
              value = val;
              if(widget.onChanged != null){
                widget.onChanged!(val);
              }
            },
            onEditingComplete: () {
              widget.done?.call(_textEditingController.text);
              Navigator.pop(context);
            },
            autofocus: true,
            onTap: (){

            },
            decoration: const InputDecoration(
                fillColor: Colors.white,
                filled: true),
          ),
        ),
      ),
    );
  }
}
