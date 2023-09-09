import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:ecommerce_demo/utils/extension/ex_string.dart';


final botToastBuilder = BotToastInit();

int time(){
  final int now = ((DateTime.now().millisecondsSinceEpoch) / 1000).ceil();
  return now;
}

DateTime dateTimeNow([int? second]){
  return DateTime.fromMillisecondsSinceEpoch(((second != null)?second:time()) * 1000);
}

String date([dynamic time, String? format]) {
  String _format = format ?? 'dd/MM/yyyy';
  if (!empty(time)) {
    if ((time is String || time is num)) {
      if(time is int){
        return DateFormat(_format).format(DateTime.fromMillisecondsSinceEpoch(time * 1000));
      }
      final _reg = RegExp(r'(\d{4})-(\d{2})-(\d{2})T(\d{2}):(\d{2}):(\d{2})');
      if(time is String && _reg.hasMatch(time)){
        DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
        DateTime dateTime = dateFormat.parse(time.toString().replaceFirst('T', ' '));

        return DateFormat(_format).format(dateTime);
      }
      return DateFormat(_format).format(time.toString().toDateTime());
    }else if(time is DateTime){
      return DateFormat(_format).format(time);
    }
  }else{
    return '';
  }
  return '';
}


String number(dynamic value) {
  if(value is num || (value is String && RegExp(r'^\d+$').hasMatch(value))) {
    final RegExp _reg = RegExp(r'(\d)(?=(\d{3})+$)');
    final newString = value.toString().replaceAllMapped(_reg, (match) {
      return '${match.group(1)}${'.'}';
    });
    return newString;
  }
  return value;
}

Color? darken(Color color, [double amount = .1]) {
  if(color == null){
    return null;
  }
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color? lighten(Color? color, [double amount = .1]) {
  if(color == null){
    return null;
  }
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}



empty(dynamic data){
  if(data == null){
    return true;
  }
  if(data is List && data.isEmpty) return true;
  if(data is Map && data.isEmpty) return true;
  if(data is String && data.isNotEmpty) return false;
  if(data.toString().isNotEmpty) return false;
  if(data == true) return false;
  return true;
}


/// dùng để in ra tất cả dữ liệu
print_r(dynamic data){
  if(data is Map){
    data.forEach((key, value) {
      if (kDebugMode) {
        print('$key : $value');
      }
    });
  }else if(data is List){
    for(var val in data){
      if (kDebugMode) {
        print('${val.runtimeType} : $val');
      }
    }
  }else{
    if (kDebugMode) {
      print('${data.runtimeType}');
    }
  }
}

extension RestTimeOnDuration on Duration {
  int get inDaysRest => inDays;
  int get inHoursRest => inHours - (inDays * 24);
  int get inMinutesRest => inMinutes - (inHours * 60);
  int get inSecondsRest => inSeconds - (inMinutes * 60);
  int get inMillisecondsRest => inMilliseconds - (inSeconds * 1000);
  int get inMicrosecondsRest => inMicroseconds - (inMilliseconds * 1000);
}