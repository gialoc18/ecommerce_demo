import 'dart:math';

extension ExNum on num{
  String toRound([int places = 1]){
    if(toString().contains('.')){
      String val = '';
      double index = double.parse((this / 1.0).toStringAsFixed(places));
      double n = double.parse((this / 1.0).toStringAsFixed(places + 1));
      String _temp = ((n * pow(10, (places + 1))).toInt() %  pow(10, (places)).toInt()).toString();
      if(int.parse(_temp[0]) >= 5){
        val = (index + (1/pow(10, places))).toStringAsFixed(places);
      }else{
        val = index.toString();
      }
      return val;
    }
    return toString();
  }
}