import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_demo/services/localization.dart';
import 'package:ecommerce_demo/utils/helper.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/app_theme.dart';
import 'controller/app_lib.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'global.dart';
import 'page/cart/controller.dart';
import 'page/shop/controller.dart';


app({
  String? title,
  String? initialRouter,
  Map<String, WidgetBuilder>? routers,
  RouteFactory? generateRoute,
}) async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
    ),
  );

  if(!kIsWeb){
    var path = (await path_provider.getApplicationDocumentsDirectory()).path;
    Hive.init(path);
  }else{
    await Hive.initFlutter();
  }

  await storage.init();

  runApp(
      _MyApp(
        title: title,
        generateRoute: generateRoute,
        initialRouter: initialRouter,
        routers: routers,
      )
  );

}


class _MyApp extends StatefulWidget {
  final String? title;
  final String? initialRouter;
  final Map<String, WidgetBuilder>? routers;
  final RouteFactory? generateRoute;
  const _MyApp({Key? key, this.title, this.initialRouter, this.routers, this.generateRoute}) : super(key: key);

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => AppLib(),),
        ChangeNotifierProvider(create: (BuildContext context) => ShopController(),),
        // ChangeNotifierProvider(create: (BuildContext context) => CartController(),),
      ],
      child: Consumer<AppLib>(
        builder: (context, controller, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: widget.initialRouter,
          locale: controller.getlocale,
          supportedLocales: const [
            // Locale('en', 'en_US'),
            Locale('en'),
            Locale('vi'),
            Locale('es'),
            Locale('ru'),
          ],
          localizationsDelegates: const [
            AppLocalizationDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          routes: widget.routers??{},
          onGenerateRoute: widget.generateRoute,
          title: widget.title??'app_title',
          scrollBehavior: const ScrollBehavior(),
          builder: botToastBuilder,
          darkTheme: AppTheme.darkTheme,
          themeMode: controller.themeMode,
          theme: AppTheme.lightTheme,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}