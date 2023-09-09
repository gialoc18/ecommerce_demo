import 'package:flutter/material.dart';
import 'package:ecommerce_demo/config/app_colors.dart';
import 'package:ecommerce_demo/routers.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      Navigator.pushNamed(context, AppRoutes.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryBackGroundColor,
      body: Center(child: FlutterLogo(size: 100,))
    );
  }
}
