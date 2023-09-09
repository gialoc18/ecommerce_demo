import 'dart:ui' as ui;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_demo/services/localization.dart';

extension ExString on String? {
  bool isNullOrEmpty() {
    return this == null || this!.isEmpty;
  }

}

extension StringBase on String{
  String date([String? format]){
    final String type = format ?? 'dd/MM/yyy';
    if(isNotEmpty || this is num){
      return DateFormat(type).format(toString().toDateTime());
    }
    return '';
  }

  DateTime toDateTime(){
    RegExp regExpNum = RegExp(r"^\s*\d*\s*$",multiLine: true,caseSensitive: false);
    if(regExpNum.hasMatch(toString()) == true){
      return DateTime.fromMicrosecondsSinceEpoch(int.parse(this) * 1000);
    }
    return DateTime.now();
  }


  Size textSize(double maxWidth, TextStyle style,{int? maxLines, TextAlign? align}){
    final TextPainter textPainter = TextPainter(
      textAlign: align ?? TextAlign.left,
      maxLines: maxLines,
      text: TextSpan(
        text: this,
        style: style,
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: maxWidth);
    return textPainter.size;
  }

  String lang(context) {
    return AppLocalization.of(context)!.translate(this);
  }
}