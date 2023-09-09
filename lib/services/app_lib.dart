import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_demo/language.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppLib extends ChangeNotifier{

  AppLib(){
    _init();
  }

  _init() async{

    notifyListeners();
  }

  String? currentLanguage;
  Locale? locale;

  ThemeMode? themeMode;

  LanguageHelper languageHelper = LanguageHelper();

  Locale? get getlocale => locale;


  void changeLocale(String newLocale) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Locale convertedLocale;

    currentLanguage = newLocale;

    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);
    locale = convertedLocale;

    await prefs.setString('language', newLocale);

    notifyListeners();
  }

  defineCurrentLanguage(context) {
    String? definedCurrentLanguage;

    if (currentLanguage != null) {
      definedCurrentLanguage = currentLanguage;
    } else {
      if (kDebugMode) {
        print(
          "locale from currentData: ${Localizations.localeOf(context).toString()}");
      }
      definedCurrentLanguage = languageHelper
          .convertLocaleToLangName(Localizations.localeOf(context).toString());
    }

    return definedCurrentLanguage;
  }

  onChangeTheme(String theme) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    switch(theme){
      case 'light':
        themeMode = ThemeMode.light;
        break;
      case 'dark':
        themeMode = ThemeMode.dark;
        break;
      default:
        themeMode = ThemeMode.system;
    }
    await prefs.setString('themeMode', '$themeMode');
    notifyListeners();
  }

  convertThemeString(String theme){
    switch(theme){
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

}