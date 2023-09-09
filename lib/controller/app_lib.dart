import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_demo/global.dart';
import 'package:ecommerce_demo/language.dart';
import 'package:ecommerce_demo/utils/helper.dart';

class AppLib extends ChangeNotifier{

  AppLib(){
    _init();
  }

  Locale? locale;

  ThemeMode? themeMode;

  Locale? get getlocale => locale;

  String? currentLanguage;

  double _volume = 1.0;
  double get volume => _volume;

  String mute = '';

  LanguageHelper languageHelper = LanguageHelper();

  _init() async{
    _initDataToDo();
    _settingsInit();
    _audioInit();
  }


  _initDataToDo() async{
    await toDoStorage.init();
  }



  _settingsInit() async{
    var currentLanguage = await storage.get('language');
    var themeMode = await storage.get('themeMode');
    locale = !empty(currentLanguage)? await languageHelper.convertLangNameToLocale(currentLanguage):const Locale('en');
    this.themeMode = !empty(themeMode)?await convertStringTheme(themeMode):ThemeMode.light;
    this.currentLanguage = await languageHelper.convertLocaleToLangName(locale!.languageCode);
    notifyListeners();
  }

  _audioInit() async{
    var audio = await storage.get('audio')??{};
    _volume = (!empty(audio) && !empty(audio['volume']))? audio['volume']:0.8;
    mute = (!empty(audio) && !empty(audio['mute']))? audio['mute']: '';
  }

  void changeLocale(String newLocale) async{
    Locale convertedLocale;

    currentLanguage = newLocale;

    convertedLocale = languageHelper.convertLangNameToLocale(newLocale);
    locale = convertedLocale;
    await storage.put('language', newLocale);
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
    await storage.put('themeMode', '$themeMode');
    notifyListeners();
  }

  convertStringTheme(String theme) async{
    switch(theme){
      case 'ThemeMode.light':
        return ThemeMode.light;
      case 'ThemeMode.dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }


  changeVolume({double? val}) async{
    Map fields = {};
    var audio = await storage.get('audio') ?? {};
    fields = audio;
    fields['volume'] = val;
    await storage.put('audio', fields);
    _volume = val!;
    notifyListeners();
  }

  muteSound({bool val = false}) async{
    Map fields = {};
    var audio = await storage.get('audio') ?? {};
    fields = audio;
    fields['mute'] = val?'':'1';
    mute = val?'':'1';
    await storage.put('audio', fields);
    notifyListeners();
  }
}