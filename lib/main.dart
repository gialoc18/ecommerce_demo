import 'package:ecommerce_demo/env.dart';
import 'app.dart';
import 'routers.dart';

void main() {
  AppEnvironment.setAppEnvironment(Environment.dev);
  app(
    title: 'Ecommerce Demo',
    routers: AppRoutes.createRoutes,
    initialRouter: AppRoutes.initial,
    generateRoute: (settings) => AppRoutes.generateRoute(settings),
  );
}

