import 'package:flutter/material.dart';

class LanguageHelper {
  convertLangNameToLocale(String langNameToConvert) {
    Locale convertedLocale;

    switch (langNameToConvert) {
      case 'english':
        convertedLocale = const Locale('en', 'EN');
        break;
      case 'viet':
        convertedLocale = const Locale('vi');
        break;
      case 'français':
        convertedLocale = const Locale('fr', 'FR');
        break;
      case 'español':
        convertedLocale = const Locale('es', 'ES');
        break;
      case 'pусский':
        convertedLocale = const Locale('ru', 'RU');
        break;
      default:
        convertedLocale = const Locale('en', 'EN');
    }

    return convertedLocale;
  }

  convertLocaleToLangName(String? localeToConvert) {
    String langName;

    switch (localeToConvert) {
      case 'en':
        langName = "english";
        break;
      case 'fr':
        langName = "français";
        break;
      case 'es':
        langName = "español";
        break;
      case 'ru':
        langName = "pусский";
        break;
      case 'vi':
        langName = "viet";
        break;
      default:
        langName = "english";
    }

    return langName;
  }
}