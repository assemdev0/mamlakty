import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../presentation/auth/view/login_screen.dart';
import '../../presentation/auth/view/register_screen.dart';
import '../../presentation/cart/view/cart_screen.dart';
import '../../presentation/category/view/category_screen.dart';
import '../../presentation/favorite/view/favorite_screen.dart';
import '../../presentation/home/view/home_scereen.dart';
import '../../presentation/orders/view/orders_screen.dart';
import '../../presentation/profile/view/profile_screen.dart';
import '../../presentation/splash_screen/view/splash_screen.dart';
import 'strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String homeRoute = "/homeRoute";
  static const String categoryRoute = "/categoryRoute";
  static const String favoriteRoute = "/favoriteRoute";
  static const String cartRoute = "/cartRoute";
  static const String profileRoute = "/profileRoute";
  static const String orderRoute = "/orderRoute";
  static const String registerRoute = "/registerRoute";
  static const String loginRoute = "/loginRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );
      case Routes.homeRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.categoryRoute:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(),
        );

      case Routes.favoriteRoute:
        return MaterialPageRoute(
          builder: (_) => const FavoriteScreen(),
        );

      case Routes.cartRoute:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );

      case Routes.profileRoute:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );

      case Routes.orderRoute:
        return MaterialPageRoute(
          builder: (_) => const OrdersScreen(),
        );
      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (_) => RegisterScreen(),
        );
      case Routes.loginRoute:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      default:
        return unDefiendRoute();
    }
  }

  static Route<dynamic> unDefiendRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.notFound.tr()),
        ),
        body: Center(
          child: Text(
            AppStrings.notFound.tr(),
          ),
        ),
      ),
    );
  }
}
