import 'package:flutter/material.dart';

class AppRoutes extends StatefulWidget {
  const AppRoutes({super.key});

  @override
  State<AppRoutes> createState() => _AppRoutesState();
}

class _AppRoutesState extends State<AppRoutes> {
  static const login = '/login';
  static const confirmLogin = '/confirm-login';
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}