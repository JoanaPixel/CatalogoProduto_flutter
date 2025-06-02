import 'package:catalogo_produto/providers/auth_provider.dart';
import 'package:catalogo_produto/screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),

              Text(
                "Bem-vindo ao Velory Market",
                style: GoogleFonts.poppins(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D2323),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Entrar",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RegisterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9D2323),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text(
                  "Cadastrar-se",
                  style: TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 16),

              // Botão de login com Google
              OutlinedButton.icon(
                onPressed: () {
                  final authProvider = Provider.of<AuthProvider>(
                    context,
                    listen: false,
                  );
                  authProvider.loginWithGoogle(context: context);
                },
                icon: Image.asset('assets/images/google_icon.png', height: 24),
                label: const Text("Entrar com Google"),
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Color(0xFF9D2323)),
                  foregroundColor: Color(0xFF9D2323),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
