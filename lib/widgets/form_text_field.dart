import 'package:flutter/material.dart';

class FormTextField extends StatefulWidget {
  final String? value;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final ValueChanged? onChange;
  final int maxLines;
  final Decoration? decoration;
  final EdgeInsets? contentPadding;
  final double padding;
  final String? hintText;
  final ValueChanged? onPress;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final InputDecoration? inputDecoration;
  final Widget? actions;
  final bool required;

  const FormTextField(
      {Key? key,
      this.value,
      this.onTap,
      this.actions,
      this.onChange,
      this.contentPadding,
      this.maxLines = 1,
      this.onEditingComplete,
      this.decoration,
      this.padding = 12,
      this.hintText,
      this.onPress,
      this.textStyle,
      this.textAlign,
      this.inputDecoration,
      this.required = false
      })
      : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  late TextEditingController _controller;

  String? value;

  @override
  void initState() {
    value = widget.value ?? '';
    _controller = TextEditingController(text: value ?? '');
    super.initState();
  }

  @override
  void didUpdateWidget(covariant FormTextField oldWidget) {
    if (widget.value != value && oldWidget.value != widget.value) {
      _controller.text = widget.value!;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.decoration,
      padding: EdgeInsets.all(widget.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.required) ...[
            Text(widget.hintText??'',style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 3,),
          ],
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                  controller: _controller,
                  onTap: () {
                    if (widget.onTap != null) {
                      widget.onTap!();
                    }
                  },
                  onChanged: (val) {
                    value = val;
                    if (widget.onChange != null) {
                      widget.onChange!(val);
                    }
                  },
                  onEditingComplete: () {
                    if (widget.onEditingComplete != null) {
                      widget.onEditingComplete!();
                    }
                  },
                  decoration: widget.inputDecoration ??
                      InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hintText ?? '',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: widget.contentPadding ??
                            const EdgeInsets.only(
                                left: 14.0, bottom: 6.0, top: 8.0),
                        // focusedBorder: OutlineInputBorder(
                        //   borderSide: const BorderSide(color: Colors.red),
                        //   borderRadius: BorderRadius.circular(10.0),
                        // ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                  maxLines: widget.maxLines,
                ),
              ),
              if (widget.actions != null) widget.actions!
            ],
          ),
        ],
      ),
    );
  }
}
