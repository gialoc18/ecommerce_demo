import 'package:flutter/material.dart';
import 'package:ecommerce_demo/config/app_colors.dart';
import 'package:ecommerce_demo/page/cart/page.dart';
import 'package:ecommerce_demo/page/shop/page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _AppBottomNavigationState createState() => _AppBottomNavigationState();
}

class _AppBottomNavigationState extends State<HomePage> {
  final List<Widget> _children = const [
    ShopPage(),
    CartPage(),
  ];

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: const Icon(Icons.shopping_cart_rounded),
      label: 'Product'.toUpperCase(),
    ),
    BottomNavigationBarItem(
      icon: const Icon(Icons.shopping_bag_outlined),
      label: 'Cart'.toUpperCase(),
    ),
  ];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final labelTextStyle =
        Theme.of(context).textTheme.subtitle2!.copyWith(fontSize: 8.0);
    return Scaffold(
      body: _children[selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 50.0,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          selectedLabelStyle: labelTextStyle,
          unselectedLabelStyle: labelTextStyle,
          onTap: _onItemTappedTabBottom,
          items: items,
        ),
      ),
    );
  }

  _onItemTappedTabBottom(index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
