import 'package:flutter/material.dart';
import 'package:ecommerce_demo/config/app_colors.dart';
import 'package:bot_toast/bot_toast.dart';
import 'controller/storage.dart';
import 'services/todo_storage.dart';
import 'utils/helper.dart';
import 'dart:math' as math;

 ToDoStorage toDoStorage = ToDoStorage.instance;

 Storage storage = Storage();

const confettiLottie = 'assets/lottie/confetti_lottie.json';

const double degrees2Radians = math.pi / 180.0;

double padding = 12.0;

showMessage(String msg,{String? type,int timeSlow = 1, Color? textColor,Alignment align = const Alignment(0, -0.999)}){
  String _type = !empty(type)?type!.toUpperCase():'';
  Color color;
  switch(_type){
    case 'SUCCESS':
      color = Colors.green;
      break;
    case 'FAIL':
      color = Colors.red;
      break;
    case 'ERROR':
      color = Colors.red;
      break;
    case 'WARNING':
      color = Colors.orangeAccent;
      break;
    default:
      color = AppColors.primaryColor!;
  }

  BotToast.showNotification(
    backgroundColor: color,
    align: align,
    duration: Duration(seconds: timeSlow),
    title: (cancelFunc) {
      return Text(
        msg,
        maxLines: 5,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: textColor??Colors.white.withOpacity(0.3)),
      );
    },
  );

}

String convertThemeString(ThemeMode? theme){
  switch(theme){
    case ThemeMode.light:
      return 'light';
    case ThemeMode.dark:
      return 'dark';
    default:
      return 'light';
  }
}

Function showLoading = ({Widget? child, ValueChanged? onchange}){
  cusTomLoading(child: child, onchange: onchange);
};

Function disableLoading = (){
  BotToast.closeAllLoading();
};


Function cusTomLoading = ({Widget? child, ValueChanged? onchange}){
  BotToast.showCustomLoading(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: GestureDetector(
            onTap: (){
              disableLoading();
              if(onchange != null){
                onchange(true);
              }
            },
              child: child),
        );
      },
      crossPage: true
  );
};

List<Color> colors = [
  const Color(0xff4993A6),
  const Color(0xff7DA72B),
  const Color(0xff98D577),
  const Color(0xffCA5838),
  const Color(0xffC63B80),
  const Color(0xffD8CD53),
  const Color(0xffD5B248),
  const Color(0xffF4C17C),
  const Color(0xffCB8543),
  const Color(0xffF8C328),
  const Color(0xffFBEC49),
  const Color(0xffCBDC44),
  const Color(0xff56FDFE),
  const Color(0xff8BD5BC),
  const Color(0xffA246B5),
  const Color(0xff7B55BA),
  const Color(0xffAFABFC),
  const Color(0xffE6B4D5),

  const Color(0xffEE7147),
  const Color(0xffF55F2F),
  const Color(0xfff06292),
  const Color(0xffab47bc),
  const Color(0xffef5350),
  const Color(0xff00acc1),
  const Color(0xff8bc34a),
  const Color(0xff66bb6a),
  const Color(0xff26a69a),
  const Color(0xffffa726),
  const Color(0xffffca28),
  const Color(0xffff7043),
  const Color(0xffa1887f),
  const Color(0xff8d6e63),
  const Color(0xff29b6f6),
  const Color(0xff42a5f5)
];

