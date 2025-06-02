import 'package:catalogo_produto/screens/catalog_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const login = '/login';
  static const confirmLogin = '/confirm-login';
  static const productDetail = '/product-detail';
  static const cart = '/cart';
  static const checkout = '/checkout';

  static const catalog = '/catalog';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case catalog:
        return MaterialPageRoute(builder: (_) => const CatalogScreen());
      // outras rotas aqui
      default:
        return MaterialPageRoute(builder: (_) => const CatalogScreen());
    }
  }
}