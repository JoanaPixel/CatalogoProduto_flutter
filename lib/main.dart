import 'package:catalogo_produto/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';
import 'screens/AuthSelectionScreen.dart';
import 'screens/catalog_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nwglraloxlyxdojlvyfp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53Z2xyYWxveGx5eGRvamx2eWZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg1NTgwMDAsImV4cCI6MjA2NDEzNDAwMH0.KLUymMBwSWtqs4lvRqU42t2vpfMoVoQIbpaAV71WFpA',
  );

  final authProvider = AuthProvider();
  await authProvider.tryAutoLogin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Velory Market',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: ColorScheme.light(
          primary: Colors.redAccent,
          secondary: Colors.red,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: _buildHome(authProvider),
      routes: {
        AppRoutes.catalog: (context) => const CatalogScreen(),
        AppRoutes.authSelection: (context) => const AuthSelectionScreen(),
      },
    );
  }

  Widget _buildHome(AuthProvider authProvider) {
    if (authProvider.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (authProvider.isLoggedIn) {
      return const CatalogScreen();
    } else {
      return const AuthSelectionScreen();
    }
  }
}
