import 'package:catalogo_produto/screens/catalog_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: const Alignment(0, -0.3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("images/pagamento.png", height: 200),

            const SizedBox(height: 30),

            Text(
              "Pedido Confirmado!",
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1D1E20),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            Text(
              "Seu pedido foi confirmado, enviaremos um e-mail de confirmação em breve.",
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: const Color(0xFF8F959E),
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        color: const Color(0xFF9D2323),
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CatalogScreen()),
            );
          },
          child: const Text(
            "Continuar Comprando",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
