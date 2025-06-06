import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:go_router/go_router.dart';

import 'providers/auth_provider.dart';
import 'providers/cart_provider.dart';

import 'screens/AuthSelectionScreen.dart';
import 'screens/confirm_login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nwglraloxlyxdojlvyfp.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im53Z2xyYWxveGx5eGRvamx2eWZwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDg1NTgwMDAsImV4cCI6MjA2NDEzNDAwMH0.KLUymMBwSWtqs4lvRqU42t2vpfMoVoQIbpaAV71WFpA',
  );

  final authProvider = AuthProvider();
  await authProvider.tryAutoLogin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MyApp(authProvider: authProvider),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthProvider authProvider;

  const MyApp({super.key, required this.authProvider});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      refreshListenable: authProvider,
      initialLocation: '/catalog',
      redirect: (context, state) {
        final isLoggedIn = authProvider.isLoggedIn;
        final goingToAuth = state.uri.path == '/auth';

        if (!isLoggedIn && !goingToAuth) {
          return '/auth';
        }

        if (isLoggedIn && goingToAuth) {
          return '/confirm-login';
        }

        return null;
      },
      routes: [
        GoRoute(
          path: '/auth',
          builder: (context, state) => const AuthSelectionScreen(),
        ),
        GoRoute(
          path: '/confirm-login',
          builder: (context, state) => SuccessScreen(),
        ),
        // Você pode adicionar mais rotas protegidas aqui
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Velory Market',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
        colorScheme: const ColorScheme.light(
          primary: Colors.redAccent,
          secondary: Colors.red,
          background: Colors.white,
        ),
        useMaterial3: true,
      ),
    );
  }
}
