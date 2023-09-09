import 'package:ecommerce_demo/models/product.dart';
import 'package:ecommerce_demo/page/cart/page.dart';
import 'package:flutter/material.dart';
import 'page/home/page.dart';
import 'page/shop/detail/page.dart';
import 'page/start/page.dart';

class AppRoutes{
  AppRoutes._();
  static String initial = '/';
  static String home = '/home';
  static String detailProduct = '/detail/product';
  static String cart = '/cart';

  static Map<String, WidgetBuilder> createRoutes = {
    initial: (context) => const StartPage(),
    home: (context) => const HomePage(),
    // detailProduct: (context) => const ShopDetailPage(),
    // fortuneWheelDetail: (context) => const FortuneWheelDetailPage(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/': return MaterialPageRoute(builder: (_) => const StartPage());
      case '/home': return MaterialPageRoute(builder: (_) => const HomePage());
      case '/cart': return MaterialPageRoute(builder: (_) => const CartPage());
      case '/detail/product': return MaterialPageRoute(builder: (_) => ShopDetailPage(item: settings.arguments as Product,));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('404'),
              ),
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}
