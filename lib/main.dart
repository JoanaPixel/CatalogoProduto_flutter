import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/auth_provider.dart';
import 'screens/AuthSelectionScreen.dart';
import 'screens/catalog_screen.dart'; // tela pós login

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
      providers: [ChangeNotifierProvider(create: (_) => authProvider)],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Velory Market',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Colors.redAccent,
          secondary: Colors.red,
          background: Colors.black,
        ),
        useMaterial3: true,
      ),
      home:
          authProvider.isLoggedIn
              ? const CatalogScreen()
              : const AuthSelectionScreen(),
    );
  }
}
